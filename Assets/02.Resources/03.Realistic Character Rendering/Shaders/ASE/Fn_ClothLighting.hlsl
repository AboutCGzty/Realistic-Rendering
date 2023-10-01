#ifndef CLOTH_LIGHTING_INCLUDE
#define CLOTH_LIGHTING_INCLUDE
#include "Fn_Common.hlsl"

float3 ClothBRDF( float3 DiffuseColor, float3 SheenColor, float Roughness,float SheenRoughness,float SheenDFG, float3 N, float3 V, float3 L,float3 LightColor,float Shadow)
{
	float a2 = Pow4( Roughness );
	float3 H = normalize(L + V);
	float NoH = saturate(dot(N,H));
	float NoV = saturate(abs(dot(N,V)) + 1e-5);
	float NoL = saturate(dot(N,L));
	float VoH = saturate(dot(V,H));
	float3 Radiance = NoL * LightColor * Shadow * PI;
	
	float3 DiffuseLighting = Diffuse_Lambert(DiffuseColor) * Radiance;
	#if defined(_DIFFUSE_OFF)
		DiffuseLighting = half3(0,0,0);
	#endif
	// Generalized microfacet specular
	//float D = D_GGX_UE4( a2, NoH );
	//float Vis = Vis_SmithJointApprox( a2, NoV, NoL );
    float D = D_Charlie_Filament( Roughness, NoH );
	float Vis = Vis_Cloth( NoV, NoL );
	float3 F = F_Schlick_UE4( 0.04, VoH );

	float3 SpecularLighting = ((D * Vis) * F) * Radiance;
	#if defined(_SPECULAR_OFF)
		SpecularLighting = half3(0,0,0);
	#endif

	float D2 = D_Charlie_Filament( SheenRoughness, NoH );
	float Vis2 = Vis_Cloth( NoV, NoL );
	float3 F2 = SheenColor;
	float3 SheenLighting = ((D2 * Vis2) * F2) * Radiance;

	float sheenScaling = 1.0 - max(max(SheenColor.r,SheenColor.g),SheenColor.b) * SheenDFG;
	DiffuseLighting *= sheenScaling;
	SpecularLighting *= sheenScaling;

	float3 DirectLighting = DiffuseLighting + SpecularLighting + SheenLighting;
	return DirectLighting;
}

void DirectLighting_float(float3 DiffuseColor, float3 SheenColor, float Roughness,float SheenRoughness,float SheenDFG,
					float3 WorldPos, float3 N, float3 V,out float3 DirectLighting)
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
        DirectLighting_MainLight = ClothBRDF(DiffuseColor,SheenColor,Roughness,SheenRoughness,SheenDFG,N,V,L,LightColor,Shadow);
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
        DirectLighting_AddLight += ClothBRDF(DiffuseColor,SheenColor,Roughness,SheenRoughness,SheenDFG,N,V,L,LightColor,Shadow);
    }
    #endif

    DirectLighting = DirectLighting_MainLight + DirectLighting_AddLight;
	#endif
}

void IndirectLighting_float(float3 DiffuseColor, float3 SheenColor, float Roughness,float SheenRoughness,float ClothDFG, float SheenDFG,
							float3 WorldPos, float3 N, float3 V,float Occlusion,float EnvRotation,out float3 IndirectLighting)
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
	half3 R = reflect(-V,N);
	R = RotateDirection(R,EnvRotation);
	half3 SpeucularLD = GlossyEnvironmentReflection(R,WorldPos,Roughness,1.0f);
	half3 SpecularDFG = ClothDFG * 0.04f;
	float SpecularOcclusion = GetSpecularOcclusion(NoV,Pow2(Roughness),Occlusion);
	float3 SpecularAO = AOMultiBounce(float3(0.04,0.04,0.04),SpecularOcclusion);
	float3 IndirectSpecular = SpeucularLD * SpecularDFG * SpecularAO;
	#if defined(_IBL_OFF)
		IndirectSpecular = half3(0,0,0);
	#endif

	half3 SheenSpeucularLD = GlossyEnvironmentReflection(R,WorldPos,SheenRoughness,1.0f);
	half3 SheenSpecularDFG = SheenColor * SheenDFG;
	float SheenOcclusion = GetSpecularOcclusion(NoV,Pow2(SheenRoughness),Occlusion);
	float3 SheenAO = AOMultiBounce(SheenColor,SheenOcclusion);
	float3 SheenSpecular = SheenSpeucularLD * SheenSpecularDFG * SheenAO;

	float sheenScaling = 1.0 - max(max(SheenColor.r,SheenColor.g),SheenColor.b) * SheenDFG;
	IndirectDiffuse *= sheenScaling;
	IndirectSpecular *= sheenScaling;

	IndirectLighting = IndirectDiffuse + IndirectSpecular + SheenSpecular;
	#endif
}

#endif