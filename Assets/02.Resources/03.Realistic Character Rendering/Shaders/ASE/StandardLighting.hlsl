#ifndef STANDARD_LIGHTING_INCLUDE
#define STANDARD_LIGHTING_INCLUDE
#include "Assets/02.Resources/03.Realistic Character Rendering/Shaders/ASE/LightingCommon.hlsl"

float3 StandardBRDF(float3 DiffuseColor, float3 SpecularColor, float Roughness, float3 N, float3 V, float3 L, float3 LightColor, float Shadow)
{
    float a2 = Pow4(Roughness);
    float3 H = normalize(L + V);
    float NoH = saturate(dot(N, H));
    float NoV = saturate(abs(dot(N, V)) + 1e-5);
    float NoL = saturate(dot(N, L));
    float VoH = saturate(dot(V, H));
    float3 Radiance = NoL * LightColor * Shadow * PI;
    
    float3 DiffuseTerm = Diffuse_Lambert(DiffuseColor) * Radiance;
    #if defined(_DIFFUSE_OFF)
        DiffuseTerm = half3(0, 0, 0);
    #endif
    // Generalized microfacet specular
    float D = D_GGX_UE4(a2, NoH);
    float Vis = Vis_SmithJointApprox(a2, NoV, NoL);
    float3 F = F_Schlick_UE4(SpecularColor, VoH);
    float3 SpecularTerm = ((D * Vis) * F) * Radiance;
    #if defined(_SPECULAR_OFF)
        SpecularTerm = half3(0, 0, 0);
    #endif

    float3 DirectLighting = DiffuseTerm + SpecularTerm;
    return DirectLighting;
}

void DirectLighting_float(float3 DiffuseColor, float3 SpecularColor, float Roughness, float3 WorldPos, float3 N, float3 V,
out float3 DirectLighting)
{
    DirectLighting = half3(0, 0, 0);
    #ifndef SHADERGRAPH_PREVIEW
        #if defined(_MAIN_LIGHT_SHADOWS_SCREEN) && !defined(_SURFACE_TYPE_TRANSPARENT)
            float4 positionCS = TransformWorldToHClip(WorldPos);
            float4 ShadowCoord = ComputeScreenPos(positionCS);
        #else
            float4 ShadowCoord = TransformWorldToShadowCoord(WorldPos);
        #endif
        float4 ShadowMask = float4(1.0, 1.0, 1.0, 1.0);
        //����Դ
        half3 DirectLighting_MainLight = half3(0, 0, 0);
        {
            Light light = GetMainLight(ShadowCoord, WorldPos, ShadowMask);
            half3 L = light.direction;
            half3 LightColor = light.color;
            half Shadow = light.shadowAttenuation;
            DirectLighting_MainLight = StandardBRDF(DiffuseColor, SpecularColor, Roughness, N, V, L, LightColor, Shadow);
        }
        //���ӹ�Դ
        half3 DirectLighting_AddLight = half3(0, 0, 0);
        #ifdef _ADDITIONAL_LIGHTS
            uint pixelLightCount = GetAdditionalLightsCount();
            for (uint lightIndex = 0; lightIndex < pixelLightCount; ++lightIndex)
            {
                Light light = GetAdditionalLight(lightIndex, WorldPos, ShadowMask);
                half3 L = light.direction;
                half3 LightColor = light.color;
                half Shadow = light.shadowAttenuation * light.distanceAttenuation;
                DirectLighting_AddLight += StandardBRDF(DiffuseColor, SpecularColor, Roughness, N, V, L, LightColor, Shadow);
            }
        #endif

        DirectLighting = DirectLighting_MainLight + DirectLighting_AddLight;
    #endif
}

void IndirectLighting_float(float3 DiffuseColor, float3 SpecularColor, float Roughness, float3 WorldPos, float3 N, float3 V,
float Occlusion, float EnvRotation, out float3 IndirectLighting)
{
    IndirectLighting = half3(0, 0, 0);
    #ifndef SHADERGRAPH_PREVIEW
        float NoV = saturate(abs(dot(N, V)) + 1e-5);
        //SH
        float3 DiffuseAO = AOMultiBounce(DiffuseColor, Occlusion);
        float3 RadianceSH = SampleSH(N);
        float3 IndirectDiffuse = RadianceSH * DiffuseColor * DiffuseAO;
        #if defined(_SH_OFF)
            IndirectDiffuse = half3(0, 0, 0);
        #endif
        //IBL
        half3 R = reflect(-V, N);
        R = RotateDirection(R, EnvRotation);
        half3 SpeucularLD = GlossyEnvironmentReflection(R, WorldPos, Roughness, Occlusion);
        half3 SpecularDFG = EnvBRDFApprox(SpecularColor, Roughness, NoV);
        float SpecularOcclusion = GetSpecularOcclusion(NoV, Pow2(Roughness), Occlusion);
        float3 SpecularAO = AOMultiBounce(SpecularColor, SpecularOcclusion);
        float3 IndirectSpecular = SpeucularLD * SpecularDFG * SpecularAO;
        #if defined(_IBL_OFF)
            IndirectSpecular = half3(0, 0, 0);
        #endif

        IndirectLighting = IndirectDiffuse + IndirectSpecular;
    #endif
}

#endif