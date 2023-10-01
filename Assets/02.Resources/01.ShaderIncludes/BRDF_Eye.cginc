#ifndef BRDFLIBRARY_INCULDE
#define BRDFLIBRARY_INCULDE
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/GlobalIllumination.hlsl"

float2 UVScaleByCenter(float2 UV, float Scale)
{
    return (UV / Scale + (0.5).xx) - (0.5 / Scale).xx;
}

float2 UVScaleByCircle(float2 UV, float Scale)
{
    float2 UVcentered = UV - float2(0.5f, 0.5f);
    float UVlength = length(UVcentered);
    // UV on circle at distance 0.5 from the center, in direction of original UV
    float2 UVmax = normalize(UVcentered) * 0.5f;

    float2 UVscaled = lerp(UVmax, float2(0.f, 0.f), saturate((1.f - UVlength * 2.f) * Scale));
    return UVscaled + float2(0.5f, 0.5f);
}

float3 NormalBlend(float3 normalA, float3 normalB)
{
    return normalize(float3(normalA.xy + normalB.xy, normalA.z * normalB.z));
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

float3 EyeRefraction(float2 UV, float3 NormalDir, float3 ViewDir, float IOR, float IrisUVRadius, float IrisDepth, float3 EyeDirection, float3 WorldTangent)
{
    // 初始化值
    float2 IrisUV = float2(0.5, 0.5);
    float IrisConcavity = 1.0;
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
    return float3(IrisUV, IrisConcavity);
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
float Vis_SmithJointApprox(float a2, float NoV, float NoL)
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

float3 EyeDirectBRDF_UE4(float3 DiffuseColor, float3 SpecularColor, float Roughness, float3 N, float3 V, float3 L, float IrisMask, float3 IrisNormal, float3 CausticNormal, float3 LightColor, float Shadow, float3 lut, float DiffuseStrength, float SpecularStrength)
{
    float a2 = Pow4_UE4(Roughness);
    float3 H = normalize(L + V);
    float NoH = saturate(dot(N, H));
    float NoV = saturate(abs(dot(N, V)) + 1e-5);
    float VoH = saturate(dot(V, H));
    float NoL = saturate(dot(N, L));
    // ---------------
    //#region 漫反射项
    float IrisNoL = saturate(dot(IrisNormal, L));
    float Power = lerp(12.0, 1.0, IrisNoL);
    float Caustic = 0.3 + (0.8 + 0.2 * (Power + 1)) * pow(saturate(dot(CausticNormal, L)), Power);
    IrisNoL *= Caustic;
    float3 NoL_Diff = lerp(lut, float3(IrisNoL, IrisNoL, IrisNoL), IrisMask);
    float3 diffuseRadians = NoL_Diff * LightColor;
    #ifdef _DIRECTDIFFUSE
        float3 diffuseTerm = Diffuse_Lambert(DiffuseColor) * diffuseRadians;
        // ------------------
        // 为了匹配unity的效果
        diffuseTerm *= PI * DiffuseStrength;
    #else
        float3 diffuseTerm = 0.0;
    #endif
    //#endregion

    // -----------------
    //#region 镜面反射项
    // -------------
    // 直接光镜面反射
    float D = D_GGX_UE4(a2, NoH);
    float Vis = Vis_SmithJointApprox(a2, NoV, NoL);
    float3 F = F_Schlick_UE4(SpecularColor, VoH);
    float3 specularBRDF = (D * Vis) * F;
    float3 specularRadians = NoL * LightColor * Shadow;
    #ifdef _DIRECTSPECULAR
        float3 specularTerm = specularBRDF * specularRadians;
        // ------------------
        // 为了匹配unity的效果
        specularTerm *= PI * SpecularStrength;
    #else
        float3 specularTerm = 0.0;
    #endif
    // --------
    // 能量守恒
    float3 energyLoss = F_Schlick_UE4(0.04, VoH) * IrisMask;
    diffuseTerm *= (1.0 - energyLoss);
    specularTerm *= (1.0 - energyLoss);
    //#endregion

    // 最终结果
    float3 directLighting = diffuseTerm + specularTerm;
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
    return saturate(pow(NoV + AO, RoughnessSq) - 1 + AO);
}

float3 AOMultiBounce(float3 BaseColor, float AO)
{
    float3 a = 2.0404 * BaseColor - 0.3324;
    float3 b = -4.7951 * BaseColor + 0.6417;
    float3 c = 2.7552 * BaseColor + 0.6903;
    return max(AO, ((AO * a + b) * AO + c) * AO);
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

float3 EyesIndirectBRDF_UE4(float3 DiffuseColor, float3 SpecularColor, float Roughness, float3 positionWS, float3 N, float3 V, float Occlusion, float EnvRotation, float DiffuseStrength, float SpecularStrength)
{
    // ----------
    // SH内置 *PI
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
    // ---------------------
    // IBL[SplitSum - Part1]
    float3 rDir = normalize(reflect(-V, N));
    rDir = RotateDirection(rDir, EnvRotation);
    float3 specularLD = GlossyEnvironmentReflection(rDir, positionWS, Roughness, Occlusion);
    // -------------------------
    // 数值拟合[SplitSum - Part2]
    float NoV = saturate(abs(dot(N, V)) + 1e-5);
    #ifdef _INDIRECTSPECULAR
        float3 specularDFG = EnvBRDFApprox_UE4(SpecularColor, Roughness, NoV);
    #else
        float3 specularDFG = 0.0;
    #endif
    // --------------------
    // 进阶改造 AO，防止漏光
    float3 specularOcclusion = GetSpecularOcclusion(NoV, Pow2_UE4(Roughness), Occlusion);
    float3 specularAO = AOMultiBounce(SpecularColor, specularOcclusion);
    // -------------
    // 计算间接光结果
    float3 indirectSpecular = specularLD * specularDFG * specularAO;
    indirectSpecular *= SpecularStrength;
    // --------
    // 最终结果
    float3 indirectLighting = indirectDiffuse + indirectSpecular;
    return indirectLighting;
}

#endif