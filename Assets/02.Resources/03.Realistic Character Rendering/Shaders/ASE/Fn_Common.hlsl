#ifndef LIGHTING_COMMON_INCLUDE
#define LIGHTING_COMMON_INCLUDE

void GetSSAO_float(float2 ScreenUV,out float SSAO)
{
	SSAO = 1.0f;
	#ifndef SHADERGRAPH_PREVIEW
	#if defined(_SCREEN_SPACE_OCCLUSION)
        AmbientOcclusionFactor aoFactor = GetScreenSpaceAmbientOcclusion(ScreenUV);
        SSAO = aoFactor.indirectAmbientOcclusion;
    #endif
	#endif
}

void GetCurvature_float(float SSSRange,float SSSPower,float3 WorldNormal,float3 WorldPos,out float Curvature)
{
    Curvature = 1.0;
    #ifndef SHADERGRAPH_PREVIEW
    float deltaWorldNormal = length( abs(ddx_fine(WorldNormal)) + abs(ddy_fine(WorldNormal)) );
	float deltaWorldPosition = length( abs(ddx_fine(WorldPos)) + abs(ddy_fine(WorldPos)) ) / 0.001;
    Curvature = saturate(SSSRange + deltaWorldNormal / deltaWorldPosition * SSSPower);
    #endif
}	

float GetMainLightShadow(float3 WorldPos)
{
	#ifndef SHADERGRAPH_PREVIEW
	#if defined(_MAIN_LIGHT_SHADOWS_SCREEN) && !defined(_SURFACE_TYPE_TRANSPARENT)
    float4 clipPos = TransformWorldToHClip(WorldPos);
    float4 ShadowCoord = ComputeScreenPos(clipPos);
    #else
	float4 ShadowCoord = TransformWorldToShadowCoord(WorldPos);
    #endif
    float ShadowMask = float4(1.0,1.0,1.0,1.0);
    Light MainLight = GetMainLight(ShadowCoord,WorldPos,ShadowMask);
	half Shadow = MainLight.shadowAttenuation;
	return Shadow;
	#endif
	return 1.0;
}

inline half Pow2 (half x)
{
    return x*x;
}
inline half Pow4 (half x)
{
    return x*x * x*x;
}
inline half Pow5 (half x)
{
    return x*x * x*x * x;
}

float3 Diffuse_Lambert( float3 DiffuseColor )
{
	return DiffuseColor * (1 / PI);
}
// GGX / Trowbridge-Reitz
// [Walter et al. 2007, "Microfacet models for refraction through rough surfaces"]
float D_GGX_UE4( float a2, float NoH )
{
	float d = ( NoH * a2 - NoH ) * NoH + 1;	// 2 mad
	return a2 / ( PI*d*d );					// 4 mul, 1 rcp
}
float D_Charlie_Filament(float Roughness, float NoH) {
    // Estevez and Kulla 2017, "Production Friendly Microfacet Sheen BRDF"
    float invAlpha  = 1.0 / Pow2(Roughness);
    float cos2h = NoH * NoH;
    float sin2h = max(1.0 - cos2h, 0.0078125); // 2^(-14/2), so sin2h^2 > 0 in fp16
    return (2.0 + invAlpha) * pow(sin2h, invAlpha * 0.5) / (2.0 * PI);
}
// Anisotropic GGX
// [Burley 2012, "Physically-Based Shading at Disney"]
float D_GGXaniso( float ax, float ay, float NoH, float XoH, float YoH )
{
	float a2 = ax * ay;
	float3 V = float3(ay * XoH, ax * YoH, a2 * NoH);
	float S = dot(V, V);

	return (1.0f / PI) * a2 * Pow2(a2 / S);
}

float Vis_Implicit()
{
	return 0.25;
}
// Appoximation of joint Smith term for GGX
// [Heitz 2014, "Understanding the Masking-Shadowing Function in Microfacet-Based BRDFs"]
float Vis_SmithJointApprox( float a2, float NoV, float NoL )
{
	float a = sqrt(a2);
	float Vis_SmithV = NoL * ( NoV * ( 1 - a ) + a );
	float Vis_SmithL = NoV * ( NoL * ( 1 - a ) + a );
	return 0.5 * rcp( Vis_SmithV + Vis_SmithL );
}
float Vis_Cloth( float NoV, float NoL )
{
	return saturate(1.0 / (4.0 * (NoL + NoV - NoL * NoV)));
}
// [Heitz 2014, "Understanding the Masking-Shadowing Function in Microfacet-Based BRDFs"]
float Vis_SmithJointAniso(float ax, float ay, float NoV, float NoL, float XoV, float XoL, float YoV, float YoL)
{
	float Vis_SmithV = NoL * length(float3(ax * XoV, ay * YoV, NoV));
	float Vis_SmithL = NoV * length(float3(ax * XoL, ay * YoL, NoL));
	return 0.5 * rcp(Vis_SmithV + Vis_SmithL);
}

float3 F_None( float3 SpecularColor )
{
	return SpecularColor;
}
// [Schlick 1994, "An Inexpensive BRDF Model for Physically-Based Rendering"]
float3 F_Schlick_UE4( float3 SpecularColor, float VoH )
{
	float Fc = Pow5( 1 - VoH );					// 1 sub, 3 mul
	//return Fc + (1 - Fc) * SpecularColor;		// 1 add, 3 mad
	
	// Anything less than 2% is physically impossible and is instead considered to be shadowing
	return saturate( 50.0 * SpecularColor.g ) * Fc + (1 - Fc) * SpecularColor;
	
}

float3 SpecularGGX( float Roughness, float3 SpecularColor,float NoH,float NoV, float NoL,float VoH)
{
	float a2 = Pow4( Roughness );
	
	// Generalized microfacet specular
	float D = D_GGX_UE4( a2, NoH );
	float Vis = Vis_SmithJointApprox( a2, NoV, NoL );
	float3 F = F_Schlick_UE4( SpecularColor, VoH );

	return (D * Vis) * F;
}

float3 DualSpecularGGX( float Lobe0Roughness,float Lobe1Roughness,float LobeMix, float3 SpecularColor,float NoH,float NoV, float NoL,float VoH)
{
	float Lobe0Alpha2 = Pow4( Lobe0Roughness );
	float Lobe1Alpha2 = Pow4( Lobe1Roughness );
	float AverageAlpha2 = Pow4( (Lobe0Roughness + Lobe1Roughness) * 0.5 );

	// Generalized microfacet specular
	float D = lerp(D_GGX_UE4( Lobe0Alpha2, NoH ),D_GGX_UE4( Lobe1Alpha2, NoH ),1.0 - LobeMix);
	float Vis = Vis_SmithJointApprox( AverageAlpha2, NoV, NoL );
	float3 F = F_Schlick_UE4( SpecularColor, VoH );

	return (D * Vis) * F;
}

float3 DualSpecularFlakes( float Lobe0Roughness,float Lobe1Roughness,float LobeMix, float3 SpecularColor,float NoH,float NoV, float NoL,float VoH)
{
	float Lobe0Alpha2 = Pow4( Lobe0Roughness );
	float Lobe1Alpha2 = Pow4( Lobe1Roughness );
	float AverageAlpha2 = Pow4( (Lobe0Roughness + Lobe1Roughness) * 0.5 );

	// Generalized microfacet specular
	float D = lerp(D_GGX_UE4( Lobe0Alpha2, NoH ),D_GGX_UE4( Lobe1Alpha2, NoH ),1.0 - LobeMix);
	float Vis = Vis_SmithJointApprox( AverageAlpha2, NoV, NoL );
	float3 F = SpecularColor;

	return (D * Vis) * F;
}

float3 SpecularFlakes(float3 SpecularColor,float Lobe0Roughness,float Lobe1Roughness,float3 WorldPos, float3 N, float3 V)
{
	#if defined(_MAIN_LIGHT_SHADOWS_SCREEN) && !defined(_SURFACE_TYPE_TRANSPARENT)
	float4 positionCS = TransformWorldToHClip(WorldPos);
    float4 ShadowCoord = ComputeScreenPos(positionCS);
	#else
    float4 ShadowCoord = TransformWorldToShadowCoord(WorldPos);
	#endif
	float4 ShadowMask = float4(1.0,1.0,1.0,1.0);
    //--------直接光照--------
    //主光
    half3 DirectLighting_MainLight = half3(0,0,0);
    {
		Light MainLight = GetMainLight(ShadowCoord,WorldPos,ShadowMask);
		half3 L = MainLight.direction;
		half3 LightColor = MainLight.color;
		float Shadow = MainLight.shadowAttenuation;

		float3 H = normalize(L + V);
		float NoH = saturate(dot(N,H));
		float NoV = saturate(abs(dot(N,V)) + 1e-5);
		float NoL = saturate(dot(N,L));
		float VoH = saturate(dot(V,H));
		float3 Radiance = NoL * LightColor * Shadow * PI;

		DirectLighting_MainLight = DualSpecularFlakes(Lobe0Roughness, Lobe1Roughness, 0.85, SpecularColor, 
								NoH, NoV, NoL, VoH) * Radiance;
    }
    //附加光
    half3 DirectLighting_AddLight = half3(0,0,0);
    #if defined(_ADDITIONAL_LIGHTS)
    int pixelLightCount = GetAdditionalLightsCount();
    for (int lightIndex = 0u; lightIndex < pixelLightCount; ++lightIndex)
    {
		Light light = GetAdditionalLight(lightIndex,WorldPos,ShadowMask);
        half3 L = light.direction;
        half3 LightColor = light.color;
        half Shadow = light.shadowAttenuation * light.distanceAttenuation;

		float3 H = normalize(L + V);
		float NoH = saturate(dot(N,H));
		float NoV = saturate(abs(dot(N,V)) + 1e-5);
		float NoL = saturate(dot(N,L));
		float VoH = saturate(dot(V,H));
		float3 Radiance = NoL * LightColor * Shadow * PI;

        DirectLighting_AddLight += DualSpecularFlakes(Lobe0Roughness, Lobe1Roughness, 0.85, SpecularColor, 
							NoH, NoV, NoL, VoH) * Radiance;
    }
    #endif
    float3 DirectLighting = DirectLighting_MainLight + DirectLighting_AddLight;

	return DirectLighting;
}

float3 ClearCoatGGX( float ClearCoat,float Roughness, float3 N,float3 V, float3 L,out float3 EnergyLoss)
{
	float3 H = normalize(L + V);
	float NoH = saturate(dot(N,H));
	float NoV = saturate(abs(dot(N,V)) + 1e-5);
	float NoL = saturate(dot(N,L));
	float VoH = saturate(dot(V,H));

	float a2 = Pow4( Roughness );
	
	// Generalized microfacet specular
	float D = D_GGX_UE4( a2, NoH );
	float Vis = Vis_SmithJointApprox( a2, NoV, NoL );
	float3 F = F_Schlick_UE4( float3(0.04,0.04,0.04), VoH ) * ClearCoat;
	EnergyLoss = F;

	return (D * Vis) * F;
}

half3 EnvBRDFApprox( half3 SpecularColor, half Roughness, half NoV )
{
	// [ Lazarov 2013, "Getting More Physical in Call of Duty: Black Ops II" ]
	// Adaptation to fit our G term.
	const half4 c0 = { -1, -0.0275, -0.572, 0.022 };
	const half4 c1 = { 1, 0.0425, 1.04, -0.04 };
	half4 r = Roughness * c0 + c1;
	half a004 = min( r.x * r.x, exp2( -9.28 * NoV ) ) * r.x + r.y;
	half2 AB = half2( -1.04, 1.04 ) * a004 + r.zw;

	// Anything less than 2% is physically impossible and is instead considered to be shadowing
	// Note: this is needed for the 'specular' show flag to work, since it uses a SpecularColor of 0
	AB.y *= saturate( 50.0 * SpecularColor.g );

	return SpecularColor * AB.x + AB.y;
}
inline half3 RotateDirection(half3 R, half degrees)
{
	float3 reflUVW = R;
	half theta = degrees * PI / 180.0f;
	half costha = cos(theta);
	half sintha = sin(theta);
	reflUVW = half3(reflUVW.x * costha - reflUVW.z * sintha, reflUVW.y, reflUVW.x * sintha + reflUVW.z * costha);
	return reflUVW;
}

half3 SpecularIBL(float3 R,float3 WorldPos,float Roughness,float3 SpecularColor,float NoV)
{	
	#ifndef SHADERGRAPH_PREVIEW
	half3 SpeucularLD = GlossyEnvironmentReflection(R,WorldPos,Roughness,1.0f);
	half3 SpecularDFG = EnvBRDFApprox(SpecularColor,Roughness,NoV);
	return SpeucularLD * SpecularDFG;
	#endif
	return 0;
}

float GetSpecularOcclusion(float NoV, float RoughnessSq, float AO)
{
	return saturate( pow( NoV + AO, RoughnessSq ) - 1 + AO );
}

float3 AOMultiBounce( float3 BaseColor, float AO )
{
	float3 a =  2.0404 * BaseColor - 0.3324;
	float3 b = -4.7951 * BaseColor + 0.6417;
	float3 c =  2.7552 * BaseColor + 0.6903;
	return max( AO, ( ( AO * a + b ) * AO + c ) * AO );
}

#endif