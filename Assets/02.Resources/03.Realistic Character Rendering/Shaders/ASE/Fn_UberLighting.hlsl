#ifndef STANDARD_LIGHTING_INCLUDE
#define STANDARD_LIGHTING_INCLUDE
#include "Fn_Common.hlsl"

float3 UberBRDF( float3 DiffuseColor, float3 SpecularColor, float Roughness, float ClearCoat,float ClearCoatRoughness,float3 ClearCoatNormal,
						float Iridescence,float IridescenceThickness,float3 N, float3 V, float3 L,float3 LightColor,float Shadow)
{
	float a2 = Pow4( Roughness );
	float3 H = normalize(L + V);
	float NoH = saturate(dot(N,H));
	float NoV = saturate(abs(dot(N,V)) + 1e-5);
	float NoL = saturate(dot(N,L));
	float VoH = saturate(dot(V,H));
	float3 Radiance = NoL * LightColor * Shadow * PI;
	
	float3 DiffuseTerm = Diffuse_Lambert(DiffuseColor) * Radiance;
	#if defined(_DIFFUSE_OFF)
		DiffuseTerm = half3(0,0,0);
	#endif
	// Generalized microfacet specular
	float D = D_GGX_UE4( a2, NoH );
	float Vis = Vis_SmithJointApprox( a2, NoV, NoL );
	float3 F = F_Schlick_UE4( SpecularColor, VoH );

	float topIor = lerp(1.0f, 1.5f, ClearCoat);
    float viewAngle = lerp(NoV,sqrt(1.0 + Sq(1.0 / topIor) * (Sq(dot(N, V)) - 1.0)),ClearCoat);
    float3 F_Iridescence = EvalIridescence(topIor, viewAngle, IridescenceThickness, SpecularColor);
    F = lerp(F,F_Iridescence,Iridescence);

	float3 SpecularTerm = ((D * Vis) * F) * Radiance;
	#if defined(_SPECULAR_OFF)
		SpecularTerm = half3(0,0,0);
	#endif

	//ClearCoat
	float3 EnergyLoss = float3(0.0,0.0,0.0);
	float3 ClearCoatLighting = ClearCoatGGX(ClearCoat, ClearCoatRoughness, ClearCoatNormal, V, L, EnergyLoss);

	DiffuseTerm = DiffuseTerm * (1.0 - EnergyLoss);
	SpecularTerm = SpecularTerm * (1.0 - EnergyLoss);

	float3 DirectLighting = DiffuseTerm + SpecularTerm + ClearCoatLighting;
	return DirectLighting;
}

void DirectLighting_float(float3 DiffuseColor, float3 SpecularColor, float Roughness,float3 WorldPos, float3 N, float3 V,
								float ClearCoat,float ClearCoatRoughness,float3 ClearCoatNormal,
								float Iridescence,float IridescenceThickness,out float3 DirectLighting)
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
        DirectLighting_MainLight = UberBRDF(DiffuseColor,SpecularColor,Roughness,ClearCoat,ClearCoatRoughness,ClearCoatNormal,Iridescence,IridescenceThickness,N,V,L,LightColor,Shadow);
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
        DirectLighting_AddLight += UberBRDF(DiffuseColor,SpecularColor,Roughness,ClearCoat,ClearCoatRoughness,ClearCoatNormal,Iridescence,IridescenceThickness,N,V,L,LightColor,Shadow);
    }
    #endif

    DirectLighting = DirectLighting_MainLight + DirectLighting_AddLight;
	#endif
}

void IndirectLighting_float(float3 DiffuseColor, float3 SpecularColor, float Roughness, float3 WorldPos, float3 N, float3 V,
							float Occlusion,float EnvRotation,float ClearCoat,float ClearCoatRoughness,float3 ClearCoatNormal,
							float IridescenceIBL,float IridescenceThickness,out float3 IndirectLighting)
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
	half3 SpeucularLD = GlossyEnvironmentReflection(R,WorldPos,Roughness,Occlusion);

	float topIor = lerp(1.0f, 1.5f, ClearCoat);
    float viewAngle = lerp(NoV,sqrt(1.0 + Sq(1.0 / topIor) * (Sq(dot(N, V)) - 1.0)),ClearCoat);
    float3 F_Iridescence = EvalIridescence(topIor, viewAngle, IridescenceThickness, SpecularColor);
    SpecularColor = lerp(SpecularColor,F_Iridescence,IridescenceIBL);

	half3 SpecularDFG = EnvBRDFApprox(SpecularColor,Roughness,NoV);
	float SpecularOcclusion = GetSpecularOcclusion(NoV,Pow2(Roughness),Occlusion);
	float3 SpecularAO = AOMultiBounce(SpecularColor,SpecularOcclusion);
	float3 IndirectSpecular = SpeucularLD * SpecularDFG * SpecularAO;
	#if defined(_IBL_OFF)
		IndirectSpecular = half3(0,0,0);
	#endif

	//ClearCoat
	half3 R_ClearCoat = reflect(-V,ClearCoatNormal);
	float NoV_ClearCoat = saturate(abs(dot(ClearCoatNormal,V)) + 1e-5);
	half3 ClearCoatLobe = SpecularIBL(R_ClearCoat,WorldPos,ClearCoatRoughness,float3(0.04,0.04,0.04),NoV_ClearCoat);
	half3 IndirectClearCoat = ClearCoatLobe * ClearCoat * SpecularAO;

	float3 EnergyLoss = F_Schlick_UE4( float3(0.04,0.04,0.04), NoV_ClearCoat ) * ClearCoat;
	IndirectDiffuse = IndirectDiffuse * (1.0 - EnergyLoss);
	IndirectSpecular = IndirectSpecular * (1.0 - EnergyLoss);

	IndirectLighting = IndirectDiffuse + IndirectSpecular + IndirectClearCoat;
	#endif
}

#endif