#ifndef SLIK_LIGHTING_INCLUDE
#define SLIK_LIGHTING_INCLUDE
#include "Fn_Common.hlsl"

float3 SlikBRDF( float3 DiffuseColor, float3 SpecularColor, float Roughness,float Anisotropy,
					float3 N, float3 V, float3 L,float3 X,float3 Y,float3 LightColor,float Shadow)
{
	float Alpha = Roughness * Roughness;
	float a2 = Alpha * Alpha;

	float ax = max(Alpha * (1.0 + Anisotropy), 0.001f);
	float ay = max(Alpha * (1.0 - Anisotropy), 0.001f);

	float3 H = normalize(L + V);
	float NoH = saturate(dot(N,H));
	float NoV = saturate(abs(dot(N,V)) + 1e-5);
	float NoL = saturate(dot(N,L));
	float VoH = saturate(dot(V,H));

	float XoV = dot(X,V);
	float XoL = dot(X,L);
	float XoH = dot(X,H);
	float YoV = dot(Y,V);
	float YoL = dot(Y,L);
	float YoH = dot(Y,H);

	float3 Radiance = NoL * LightColor * Shadow * PI;
	
	float3 DiffuseTerm = Diffuse_Lambert(DiffuseColor) * Radiance;
	#if defined(_DIFFUSE_OFF)
		DiffuseTerm = half3(0,0,0);
	#endif
	// Generalized microfacet specular
	//float D = D_GGX_UE4( a2, NoH );
	float D = D_GGXaniso(ax,ay,NoH,XoH,YoH);
	//float Vis = Vis_SmithJointApprox( a2, NoV, NoL );
	float Vis = Vis_SmithJointAniso(ax,ay,NoV,NoL,XoV,XoL,YoV,YoL);
	float3 F = F_Schlick_UE4( SpecularColor, VoH );
	float3 SpecularTerm = ((D * Vis) * F) * Radiance;
	#if defined(_SPECULAR_OFF)
		SpecularTerm = half3(0,0,0);
	#endif

	float3 DirectLighting = DiffuseTerm + SpecularTerm;
	return DirectLighting;
}

void DirectLighting_float(float3 DiffuseColor, float3 SpecularColor, float Roughness,float Anisotropy,
						float3 WorldPos, float3 N, float3 V,float3 X,float3 Y,
								out float3 DirectLighting)
{
	DirectLighting = half3(0,0,0);
	#ifndef SHADERGRAPH_PREVIEW
	#if defined(_MAIN_LIGHT_SHADOWS_SCREEN) && !defined(_SURFACE_TYPE_TRANSPARENT)
	float4 positionCS = TransformWorldToHClip(WorldPos);
    float4 ShadowCoord = ComputeScreenPos(positionCS);
	#else
    float4 ShadowCoord = TransformWorldToShadowCoord(WorldPos);
	#endif
	float4 ShadowMask = float4(1.0,1.0,1.0,1.0);
	//主光源
    half3 DirectLighting_MainLight = half3(0,0,0);
    {
        Light light = GetMainLight(ShadowCoord,WorldPos,ShadowMask);
        half3 L = light.direction;
        half3 LightColor = light.color;
        half Shadow = light.shadowAttenuation;
        DirectLighting_MainLight = SlikBRDF(DiffuseColor,SpecularColor,Roughness,Anisotropy,N,V,L,X,Y,LightColor,Shadow);
    }
    //附加光源
    half3 DirectLighting_AddLight = half3(0,0,0);
    #ifdef _ADDITIONAL_LIGHTS
    uint pixelLightCount = GetAdditionalLightsCount();
    for(uint lightIndex = 0; lightIndex < pixelLightCount ; ++lightIndex)
    {
        Light light = GetAdditionalLight(lightIndex,WorldPos,ShadowMask);
        half3 L = light.direction;
        half3 LightColor = light.color;
        half Shadow = light.shadowAttenuation * light.distanceAttenuation;
        DirectLighting_AddLight += SlikBRDF(DiffuseColor,SpecularColor,Roughness,Anisotropy,N,V,L,X,Y,LightColor,Shadow);
    }
    #endif

    DirectLighting = DirectLighting_MainLight + DirectLighting_AddLight;
	#endif
}

void IndirectLighting_float(float3 DiffuseColor, float3 SpecularColor, float Roughness,float Anisotropy,
							float3 WorldPos, float3 N, float3 V,half3 T,half3 B,
							float Occlusion,float EnvRotation,out float3 IndirectLighting)
{
	IndirectLighting = half3(0,0,0);
	#ifndef SHADERGRAPH_PREVIEW
	float NoV = saturate(abs(dot(N,V)) + 1e-5);
	//SH
	float3 DiffuseAO = AOMultiBounce(DiffuseColor,Occlusion);
	float3 RadianceSH = SampleSH(N);
	float3 IndirectDiffuse = RadianceSH * DiffuseColor * DiffuseAO;
	#if defined(_SH_OFF)
		IndirectDiffuse = half3(0,0,0);
	#endif
	//IBL
	float3 anisotropicDirection = Anisotropy >= 0.0 ? B : T;
    float3 anisotropicTangent = cross(anisotropicDirection, V);
    float3 anisotropicNormal = cross(anisotropicTangent, anisotropicDirection);
    float3 bentNormal = normalize(lerp(N, anisotropicNormal, abs(Anisotropy)));

	half3 R = reflect(-V,bentNormal);
	R = RotateDirection(R,EnvRotation);
	half3 SpeucularLD = GlossyEnvironmentReflection(R,WorldPos,Roughness,Occlusion);
	half3 SpecularDFG = EnvBRDFApprox(SpecularColor,Roughness,NoV);
	float SpecularOcclusion = GetSpecularOcclusion(NoV,Pow2(Roughness),Occlusion);
	float3 SpecularAO = AOMultiBounce(SpecularColor,SpecularOcclusion);
	float3 IndirectSpecular = SpeucularLD * SpecularDFG * SpecularAO;
	#if defined(_IBL_OFF)
		IndirectSpecular = half3(0,0,0);
	#endif

	IndirectLighting = IndirectDiffuse + IndirectSpecular;
	#endif
}

#endif