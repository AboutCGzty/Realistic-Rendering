#ifndef SKINBRDF_INCULDE
#define SKINBRDF_INCULDE
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/GlobalIllumination.hlsl"

float3 NormalBlending_ReorientedNormalMapping(float3 n1, float3 n2)
{
    n1.z += 1.0;
    n2.xy = -n2.xy;
    return normalize(n1 * dot(n1, n2) - n2 * n1.z);
}

float3 DirectSpecularBRDF(float D, float3 F, float G, float NV, float NL)
{
    float3 nominator = D * F * G;
    float denominator = max(0.00001, 4 * NV * NL);
    return nominator / denominator;
}

float GetCurvature(float SSSRange, float SSSPower, float3 WorldNormal, float3 WorldPos)
{
    float Curvature = 1.0;
    #ifndef SHADERGRAPH_PREVIEW
        float deltaWorldNormal = length(abs(ddx_fine(WorldNormal)) + abs(ddy_fine(WorldNormal)));
        float deltaWorldPosition = length(abs(ddx_fine(WorldPos)) + abs(ddy_fine(WorldPos))) / 0.001;
        Curvature = saturate(SSSRange + deltaWorldNormal / deltaWorldPosition * SSSPower);
        return Curvature;
    #endif
}

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
///////////////////////////////////////////////////////////////////////////////
//                                UE4 BRDF                                   //
///////////////////////////////////////////////////////////////////////////////
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
inline float Pow2_UE4(float x)
{
    return x * x;
}

inline float Pow4_UE4(float x)
{
    float xx = x * x;
    return xx * xx;
}

inline float Pow5_UE4(float x)
{
    float xx = x * x;
    return xx * xx * x;
}

float3 Diffuse_Lambert(float3 DiffuseColor)
{
    return DiffuseColor * (1 / PI);
}

float D_GGX_UE4(float a2, float NoH)
{
    float d = (NoH * a2 - NoH) * NoH + 1;	// 2 mad
    return a2 / (PI * d * d);					// 4 mul, 1 rcp

}

// Appoximation of joint Smith term for GGX
// [Heitz 2014, "Understanding the Masking-Shadowing Function in Microfacet-Based BRDFs"]
float Vis_SmithJointApprox_UE4(float a2, float NoV, float NoL)
{
    float a = sqrt(a2);
    float Vis_SmithV = NoL * (NoV * (1 - a) + a);
    float Vis_SmithL = NoV * (NoL * (1 - a) + a);
    return 0.5 * rcp(Vis_SmithV + Vis_SmithL);
}

// [Schlick 1994, "An Inexpensive BRDF Model for Physically-Based Rendering"]
float3 F_Schlick_UE4(float3 SpecularColor, float VoH)
{
    float Fc = Pow5_UE4(1 - VoH);					// 1 sub, 3 mul
    //return Fc + (1 - Fc) * SpecularColor;		// 1 add, 3 mad
    
    // Anything less than 2% is physically impossible and is instead considered to be shadowing
    return saturate(50.0 * SpecularColor.g) * Fc + (1 - Fc) * SpecularColor;
}

float3 SpecularGGX(float Roughness, float3 SpecularColor, float NoH, float NoV, float NoL, float VoH)
{
    float a2 = Pow4_UE4(Roughness);
    
    // Generalized microfacet specular
    float D = D_GGX_UE4(a2, NoH);
    float Vis = Vis_SmithJointApprox_UE4(a2, NoV, NoL);
    float3 F = F_Schlick_UE4(SpecularColor, VoH);

    return (D * Vis) * F;
}

float3 ClearCoatSpecularGGX(float ClearCoatStrength, float ClearCoatRoughness, float3 ClearCoatNormal, float3 V, float3 L, out float3 EnergyLoss)
{
    float3 H = normalize(L + V);
    float NoH = saturate(dot(ClearCoatNormal, H));
    float NoV = saturate(abs(dot(ClearCoatNormal, V)) + 1e-5);
    // Unity中使用 LoH 代替了 VoH
    float VoH = saturate(dot(V, H));
    float NoL = saturate(dot(ClearCoatNormal, L));

    float a2 = Pow4_UE4(ClearCoatRoughness);
    // Generalized microfacet specular
    float D = D_GGX_UE4(a2, NoH);
    float Vis = Vis_SmithJointApprox_UE4(a2, NoV, NoL);
    float3 F = F_Schlick_UE4(float3(0.04, 0.04, 0.04), VoH) * ClearCoatStrength;
    EnergyLoss = F;
    return (D * Vis) * F;
}

float3 DualSpecularGGX_UE4(float Lobe0Roughness, float Lobe1Roughness, float LobeMix, float3 SpecularColor, float NoH, float NoV, float NoL, float VoH)
{
    float Lobe0Alpha2 = Pow4(Lobe0Roughness);
    float Lobe1Alpha2 = Pow4(Lobe1Roughness);
    float AverageAlpha2 = Pow4((Lobe0Alpha2 + Lobe1Alpha2) * 0.5);

    // Generalized microfacet specular
    float D = lerp(D_GGX_UE4(Lobe0Alpha2, NoH), D_GGX_UE4(Lobe1Alpha2, NoH), 1.0 - LobeMix);
    float Vis = Vis_SmithJointApprox_UE4(AverageAlpha2, NoV, NoL); // Average visibility well approximates using two separate ones (one per lobe).
    float3 F = F_Schlick_UE4(SpecularColor, VoH);

    return (D * Vis) * F;
}

float3 SkinDirectBRDF_UE4(float3 DiffuseColor, float3 DiffuseShadowColor, float3 SpecularColor, float ClearCoatStrength, float ClearCoatRoughness, float3 ClearCoatNormal, float Lobe0Roughness,
float Lobe1Roughness, float LobeMix, float3 N, float3 V, float3 L, float3 LightColor, float Shadow, float3 lut, float DiffuseStrength, float SpecularStrength)
{
    float3 H = normalize(L + V);
    float NoH = saturate(dot(N, H));
    float NoV = saturate(abs(dot(N, V)) + 1e-5);
    // Unity中使用 LoH 代替了 VoH
    float VoH = saturate(dot(V, H));
    float NoL = saturate(dot(N, L));
    // --------
    // 漫反射项
    float3 diffuseRadians = NoL * LightColor * DiffuseShadowColor;
    #ifdef _SSS
        diffuseRadians = lut * LightColor * DiffuseShadowColor;
    #endif
    #ifdef _DIRECTDIFFUSE
        float3 diffuseTerm = Diffuse_Lambert(DiffuseColor) * diffuseRadians;
        // ------------------
        // 为了匹配unity的效果
        diffuseTerm *= PI * DiffuseStrength;
    #else
        float3 diffuseTerm = 0.0;
    #endif
    // ---------
    // 镜面反射项
    float specular_NoL = saturate(dot(N, L));
    float3 specularRadians = specular_NoL * LightColor * Shadow;
    // -----------------
    // 双层直接光镜面反射
    float3 specularBRDF = DualSpecularGGX_UE4(Lobe0Roughness, Lobe1Roughness, LobeMix, SpecularColor, NoH, NoV, NoL, VoH);
    #ifdef _DIRECTSPECULAR
        float3 specularTerm = specularBRDF * specularRadians;
        // ------------------
        // 为了匹配unity的效果
        specularTerm *= PI * SpecularStrength;
    #else
        float3 specularTerm = 0.0;
    #endif
    // 第二层清漆层【模拟嘴唇湿润】
    float3 energyLoss = 0.0;
    float3 clearCoat = ClearCoatSpecularGGX(ClearCoatStrength, ClearCoatRoughness, ClearCoatNormal, V, L, energyLoss);
    // 能量守恒
    diffuseTerm *= (1.0 - energyLoss);
    specularTerm *= (1.0 - energyLoss);
    // 最终结果
    float3 directLighting = diffuseTerm + specularTerm + clearCoat;
    return directLighting;
}

half3 EnvBRDFApprox_UE4(half3 SpecularColor, half Roughness, half NoV)
{
    // [ Lazarov 2013, "Getting More Physical in Call of Duty: Black Ops II" ]
    // Adaptation to fit our G term.
    const half4 c0 = {
        - 1, -0.0275, -0.572, 0.022
    };
    const half4 c1 = {
        1, 0.0425, 1.04, -0.04
    };
    half4 r = Roughness * c0 + c1;
    half a004 = min(r.x * r.x, exp2(-9.28 * NoV)) * r.x + r.y;
    half2 AB = half2(-1.04, 1.04) * a004 + r.zw;

    // Anything less than 2% is physically impossible and is instead considered to be shadowing
    // Note: this is needed for the 'specular' show flag to work, since it uses a SpecularColor of 0
    AB.y *= saturate(50.0 * SpecularColor.g);

    return SpecularColor * AB.x + AB.y;
}

float GetSpecularOcclusion(float NoV, float RoughnessSq, float AO)
{
    return saturate(pow(NoV + AO, RoughnessSq) - 1.0 + AO);
}

float3 AOMultiBounce(float3 BaseColor, float AO)
{
    float3 a = 2.0404 * BaseColor - 0.3324;
    float3 b = -4.7951 * BaseColor + 0.6417;
    float3 c = 2.7552 * BaseColor + 0.6903;
    return max(AO, ((AO * a + b) * AO + c) * AO);
}

float3 specularIBL_UE4(float3 R, float3 positionWS, float Roughness, float Occlusion, float3 SpecularColor, float NoV)
{
    float3 specularLD = GlossyEnvironmentReflection(R, positionWS, Roughness, 1.0);
    float3 specularDFG = EnvBRDFApprox_UE4(SpecularColor, Roughness, NoV);

    return specularLD * specularDFG;
}

float3 RotateDirection(float3 R, float degrees)
{
    float3 reflUVW = R;
    float theta = degrees * PI / 180.0f;
    float costha = cos(theta);
    float sintha = sin(theta);
    reflUVW = float3(reflUVW.x * costha - reflUVW.z * sintha, reflUVW.y, reflUVW.x * sintha + reflUVW.z * costha);
    return reflUVW;
}

float3 SkinIndirectBRDF_UE4(float3 DiffuseColor, float3 SpecularColor, float ClearCoatStrength, float ClearCoatRoughness, float3 ClearCoatNormal, float Lobe0Roughness, float Lobe1Roughness,
float LobeMix, float3 positionWS, float3 N, float3 V, float Occlusion, float EnvRotation, float DiffuseStrength, float SpecularStrength)
{
    // ------------------------
    // 漫反射部分使用 SH内置 *PI
    #ifdef _INDIRECTDIFFUSE
        float3 radiansSH = SampleSH(N);
    #else
        float3 radiansSH = 0.0;
    #endif
    // --------------------
    // 进阶改造 AO，防止漏光
    float3 diffuseAO = AOMultiBounce(DiffuseColor, Occlusion);
    float3 indirectDiffuse = radiansSH * DiffuseColor * diffuseAO;
    indirectDiffuse *= DiffuseStrength;
    // -----------------
    // 间接光镜面反射部分
    float avarageRoughness = (Lobe0Roughness + Lobe1Roughness) * 0.5;
    // --------------------
    // 进阶改造 AO，防止漏光
    float NoV = saturate(abs(dot(N, V)) + 1e-5);
    float3 specularOcclusion = GetSpecularOcclusion(NoV, Pow2_UE4(avarageRoughness), Occlusion);
    float3 specularAO = AOMultiBounce(SpecularColor, specularOcclusion);
    #ifdef _INDIRECTSPECULAR
        // --------
        // 反射向量
        float3 rDir = normalize(reflect(-V, N));
        rDir = RotateDirection(rDir, EnvRotation);
        // ---------------------
        // 计算双层镜面反射并混合
        float3 specularLobe0 = specularIBL_UE4(rDir, positionWS, Lobe0Roughness, Occlusion, SpecularColor, NoV);
        float3 specularLobe1 = specularIBL_UE4(rDir, positionWS, Lobe1Roughness, Occlusion, SpecularColor, NoV);
        float3 dualSpecular = lerp(specularLobe0, specularLobe1, 1.0 - LobeMix);
        // --------------------
        // 双层间接光镜面反射结果
        float3 indirectSpecular = dualSpecular * specularAO;
    #else
        float3 indirectSpecular = 0.0;
    #endif
    // -------------------------
    // 第二层清漆层【模拟嘴唇湿润】
    float NoV_ClearCoat = saturate(abs(dot(ClearCoatNormal, V)) + 1e-5);
    #ifdef _CLEARCOAT
        float3 energyLoss = 0.0;
        float3 ViewDir_clearCoar = normalize(reflect(-V, ClearCoatNormal));
        float3 clearCoat = specularIBL_UE4(ViewDir_clearCoar, positionWS, ClearCoatRoughness, Occlusion, float3(0.04, 0.04, 0.04), NoV_ClearCoat);
        clearCoat *= ClearCoatStrength * specularAO;
    #else
        float3 clearCoat = 0.0;
    #endif
    // ------------
    // 考虑能量守恒
    float3 EnergyLoss = F_Schlick_UE4(float3(0.04, 0.04, 0.04), NoV_ClearCoat) * ClearCoatStrength;
    indirectDiffuse *= (1.0 - EnergyLoss);
    indirectSpecular *= (1.0 - EnergyLoss);
    // --------
    // 最终结果
    float3 indirectLighting = indirectDiffuse + indirectSpecular + clearCoat;
    return indirectLighting;
}



#endif