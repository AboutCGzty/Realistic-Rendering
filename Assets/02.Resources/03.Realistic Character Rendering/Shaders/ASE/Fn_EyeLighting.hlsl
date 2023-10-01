#ifndef SG_DEFAULT_BXDF_INCLUDED
#define SG_DEFAULT_BXDF_INCLUDED
#include "Fn_Common.hlsl"

half2 ScaleUVsByCenter(half2 UVs, float Scale)
{
    return (UVs / Scale + (0.5).xx) - (0.5 / Scale).xx;
}
void ScaleUVsByCenter_float(half2 UVs, float Scale, out float2 UV_Scale)
{
    UV_Scale = float2(0.5, 0.5);
    #ifndef SHADERGRAPH_PREVIEW
        UV_Scale = ScaleUVsByCenter(UVs, Scale);
    #endif
}

half2 ScaleUVFromCircle(half2 UV, float Scale)
{
    float2 UVcentered = UV - float2(0.5f, 0.5f);
    float UVlength = length(UVcentered);
    // UV on circle at distance 0.5 from the center, in direction of original UV
    float2 UVmax = normalize(UVcentered) * 0.5f;

    float2 UVscaled = lerp(UVmax, float2(0.f, 0.f), saturate((1.f - UVlength * 2.f) * Scale));
    return UVscaled + float2(0.5f, 0.5f);
}
void ScaleUVFromCircle_float(half2 UV, float Scale, out float2 UV_Scale)
{
    UV_Scale = float2(0.5, 0.5);
    #ifndef SHADERGRAPH_PREVIEW
        UV_Scale = ScaleUVFromCircle(UV, Scale);
    #endif
}

float3 RefractDirection(float internalIoR, float3 WorldNormal, float3 incidentVector)
{
    float airIoR = 1.00029;

    float n = airIoR / internalIoR;

    float facing = dot(WorldNormal, incidentVector);

    float w = n * facing;

    float k = sqrt(1 + (w - n) * (w + n));

    float3 t = -normalize((w - k) * WorldNormal - n * incidentVector);
    return t;
}

void EyeRefraction_float(float2 UV, float3 NormalDir, float3 ViewDir, half IOR, float IrisUVRadius, float IrisDepth, float3 EyeDirection, float3 WorldTangent, out float2 IrisUV, out float IrisConcavity)
{
    IrisUV = float2(0.5, 0.5);
    IrisConcavity = 1.0;
    #ifndef SHADERGRAPH_PREVIEW
        // 模拟视线通过角膜后被折射
        float3 RefractedViewDir = RefractDirection(IOR, NormalDir, ViewDir);
        // -------------------------------
        // EyeDirection代表眼睛正前方的朝向
        float cosAlpha = dot(ViewDir, EyeDirection);
        // -------------------
        // 视线与眼球方向的夹角
        cosAlpha = lerp(0.325, 1, cosAlpha * cosAlpha);
        // ---------------------------------------------------
        // 虹膜深度越大，折射越强；视线与眼球方向夹角越大，折射越强
        RefractedViewDir = RefractedViewDir * (IrisDepth / cosAlpha);
        // ------------------------------------------------------------------------------------------------------
        // 根据世界空间切线方向求出与 EyeDirection 垂直的向量，也就是虹膜平面的切线方向与副切线方向，也就是 UV 的偏移方向
        float3 TangentDerive = normalize(WorldTangent - dot(WorldTangent, EyeDirection) * EyeDirection);
        float3 BiTangentDerive = normalize(cross(EyeDirection, TangentDerive));
        float RefractUVOffsetX = dot(RefractedViewDir, TangentDerive);
        float RefractUVOffsetY = dot(RefractedViewDir, BiTangentDerive);
        float2 RefractUVOffset = float2(-RefractUVOffsetX, RefractUVOffsetY);
        float2 UVRefract = UV + IrisUVRadius * RefractUVOffset;
        //UVRefract = lerp(UV,UVRefract,IrisMask);
        IrisUV = (UVRefract - float2(0.5, 0.5)) / IrisUVRadius * 0.5 + float2(0.5, 0.5);
        IrisConcavity = length(UVRefract - float2(0.5, 0.5)) * IrisUVRadius;
    #endif
}

half3 EyeBxDF(half3 DiffuseColor, half3 SpecularColor, float Roughness, half3 N, half3 V, half3 L, half IrisMask, half3 IrisNormal, half3 CausticNormal, half3 LightColor, float Shadow, float3 DiffuseShadow, Texture2D SSSLUT, SamplerState sampler_SSSLUT)
{
    float3 H = normalize(V + L);
    float NoH = saturate(dot(N, H));
    float NoV = saturate(abs(saturate(dot(N, V))) + 1e-5);
    float NoL = saturate(dot(N, L));
    float VoH = saturate(dot(V, H));

    //�����䲿��
    //��Ĥ(����β״����)
    float IrisNoL = saturate(dot(IrisNormal, L));
    float Power = lerp(12, 1, IrisNoL);
    float Caustic = 0.3 + (0.8 + 0.2 * (Power + 1)) * pow(saturate(dot(CausticNormal, L)), Power);//��ɢ
    IrisNoL = IrisNoL * Caustic;
    //��Ĥ(�۰�)
    float3 ScleraNoL = SAMPLE_TEXTURE2D(SSSLUT, sampler_SSSLUT, half2(dot(N, L) * 0.5 + 0.5, 0.9)).rgb;
    float3 NoL_Diff = lerp(ScleraNoL, IrisNoL, IrisMask);
    float3 DiffIrradiance = LightColor * PI * DiffuseShadow * NoL_Diff;
    half3 DiffuseLighting = Diffuse_Lambert(DiffuseColor) * DiffIrradiance;
    #if defined(_DIFFUSE_OFF)
        DiffuseLighting = float3(0, 0, 0);
    #endif

    //�߹�
    //��Ĥ����Ĥ(���͸����Ĥ��)
    float3 SpecIrradiance = LightColor * PI * Shadow * NoL;
    half3 SpecularLighting = SpecularGGX(Roughness, SpecularColor, NoH, NoV, NoL, VoH) * SpecIrradiance;
    float F = F_Schlick_UE4(0.04, VoH) * IrisMask;
    float Fcc = 1.0 - F;
    DiffuseLighting *= Fcc;
    
    return DiffuseLighting + SpecularLighting;
}

void DirectLighting_float(float3 DiffuseColor, float3 SpecularColor, float Roughness, float3 WorldPos,
half3 WorldNormal, half3 ViewDir, half IrisMask, half3 IrisNormal, half3 CausticNormal,
Texture2D SSSLUT, SamplerState sampler_SSSLUT, out float3 DirectLighting)
{
    DirectLighting = float3(0.5, 0.5, 0);
    #ifndef SHADERGRAPH_PREVIEW
        #if defined(_MAIN_LIGHT_SHADOWS_SCREEN) && !defined(_SURFACE_TYPE_TRANSPARENT)
            float4 clipPos = TransformWorldToHClip(WorldPos);
            float4 ShadowCoord = ComputeScreenPos(clipPos);
        #else
            float4 ShadowCoord = TransformWorldToShadowCoord(WorldPos);
        #endif
        float ShadowMask = float4(1.0, 1.0, 1.0, 1.0);
        //--------ֱ�ӹ���--------
        half3 N = WorldNormal;
        half3 V = ViewDir;
        //����
        half3 DirectLighting_MainLight = half3(0, 0, 0);
        {
            Light light = GetMainLight(ShadowCoord, WorldPos, ShadowMask);
            half3 L = light.direction;
            half3 LightColor = light.color;
            float Shadow = saturate(light.shadowAttenuation + 0.2);
            half3 DiffuseShadow = lerp(half3(0.11, 0.025, 0.012), half3(1, 1, 1), Shadow);//hard code;
            DirectLighting_MainLight = EyeBxDF(DiffuseColor, SpecularColor, Roughness, N, V, L,
            IrisMask, IrisNormal, CausticNormal, LightColor, Shadow, DiffuseShadow, SSSLUT, sampler_SSSLUT);
        }
        //���ӹ�
        half3 DirectLighting_AddLight = half3(0, 0, 0);
        #if defined(_ADDITIONAL_LIGHTS)
            int pixelLightCount = GetAdditionalLightsCount();
            for (int lightIndex = 0u; lightIndex < pixelLightCount; ++lightIndex)
            {
                Light light = GetAdditionalLight(lightIndex, WorldPos, ShadowMask);
                half3 L = light.direction;
                half3 LightColor = light.color;
                float Shadow = saturate(light.shadowAttenuation + 0.2) * light.distanceAttenuation;
                half3 DiffuseShadow = lerp(half3(0.11, 0.025, 0.012), half3(1, 1, 1), Shadow);//hard code;
                DirectLighting_AddLight += EyeBxDF(DiffuseColor, SpecularColor, Roughness, N, V, L,
                IrisMask, IrisNormal, CausticNormal, LightColor, Shadow, DiffuseShadow, SSSLUT, sampler_SSSLUT);
            }
        #endif
        DirectLighting = DirectLighting_MainLight + DirectLighting_AddLight;
    #endif
}

//��ӻ�����
void IndirectLighting_float(float3 DiffuseColor, float3 SpecularColor, float Roughness, half3 WorldPos, half3 WorldNormal, half3 ViewDir,
half Occlusion, half EnvRotation, out float3 IndirectLighting)
{
    IndirectLighting = float3(0, 0, 0);
    #ifndef SHADERGRAPH_PREVIEW
        float3 N = WorldNormal;
        float3 V = ViewDir;
        float NoV = saturate(abs(dot(N, V)) + 1e-5);
        half DiffuseAO = Occlusion;
        half SpecualrAO = GetSpecularOcclusion(NoV, Pow2(Roughness), Occlusion);
        half3 DiffOcclusion = AOMultiBounce(DiffuseColor, DiffuseAO);
        half MainLightShadow = clamp(GetMainLightShadow(WorldPos), 0.3, 1.0);
        half3 SpecOcclusion = AOMultiBounce(SpecularColor, SpecualrAO * MainLightShadow);

        //-------------SH---------
        half3 IrradianceSH = SampleSH(N);// Diffuse Lambert�е�PI�Ѿ�Bake����SH�У���˲���Ҫ����PI
        half3 IndirectDiffuse = DiffuseColor * IrradianceSH * DiffOcclusion;
        #if defined(_SH_OFF)
            IndirectDiffuse = float3(0, 0, 0);
        #endif
        //-------------IBL-------------
        half3 R = reflect(-V, N);
        R = RotateDirection(R, EnvRotation);
        half3 EnvSpecularLobe = SpecularIBL(R, WorldPos, Roughness, SpecularColor, NoV);
        half3 IndirectSpecular = EnvSpecularLobe * SpecOcclusion;
        #if defined(_IBL_OFF)
            IndirectSpecular = float3(0, 0, 0);
        #endif

        IndirectLighting = IndirectDiffuse + IndirectSpecular;
    #endif
}

#endif
