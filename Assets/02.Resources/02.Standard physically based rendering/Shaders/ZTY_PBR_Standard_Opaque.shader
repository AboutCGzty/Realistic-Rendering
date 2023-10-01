Shader "ZTY/PBR/Standard/Opaque"
{
    Properties
    {
        // ------------------
        // Rendering Settings
        [Header(Rendering Settings ____________________________________________________________________________________________________________________________________________________________________)]
        [Space(10)]
        [Enum(UnityEngine.Rendering.CullMode)]
        _CullMode ("CullMode", int) = 2
        [Toggle(_ALPHAON)]_AlphaClip ("Alpha Clip", float) = 0
        _Cutoff ("Cut off", Range(0.0, 1.0)) = 0.333
        // --------------
        // Texture Inputs
        [Header(PBR Textures ____________________________________________________________________________________________________________________________________________________________________)]
        [Space(10)]
        [NoScaleOffset] _BaseMap ("Albedo", 2D) = "white" { }
        [NoScaleOffset] _OpacityMap ("Opacity", 2D) = "white" { }
        [Normal][NoScaleOffset] _NormalMap ("Normal", 2D) = "bump" { }
        [NoScaleOffset] _MetallicMap ("Metallic", 2D) = "black" { }
        [NoScaleOffset] _RoughnessMap ("Roughness", 2D) = "gray" { }
        [NoScaleOffset] _AOMap ("AO", 2D) = "white" { }
        [NoScaleOffset] _EmissionMap ("Emission", 2D) = "black" { }
        // -------------
        // Custom Params
        [Header(Variable Members ____________________________________________________________________________________________________________________________________________________________________)]
        [Header((Color))]
        [Space(10)]
        _BaseColor ("Base Color", Color) = (1.0, 1.0, 1.0, 0.0)
        [HDR] _EmissionColor ("Emission Color", Color) = (0.0, 0.0, 0.0, 0.0)
        [Header((Bump))]
        [Space(10)]
        _NormalStrength ("Normal Strength", Range(0.0, 1.0)) = 1.0
        [Header((Reflection))]
        [Space(10)]
        _MetallicStrength ("Metallic Strength", Range(0.0, 1.0)) = 0.0
        _RoughnessStrength ("Roughness Strength", Range(0.0, 1.0)) = 0.5
        _AOStrength ("AO Strength", Range(0.0, 1.0)) = 1.0
        // -----
        // Debug
        [Header(Debug Mode ____________________________________________________________________________________________________________________________________________________________________)]
        [Header((Color))]
        [Space(10)]
        [Toggle(_EMISSION)]_EMISSION ("Emission On", int) = 0
        [KeywordEnum(DirectDiffuse, DirectSpecular, IndirectDiffuse, IndirectSpecular, DirectLighting, IndirectLighting, All)]_LightingCheck ("Lighting Check", float) = 6.0
        [KeywordEnum(UE, Unity, SP)]_DMode ("D Mode", float) = 0.0
    }

    SubShader
    {
        // --------------
        // SubShader tags
        Tags
        {
            "RenderType" = "Opaque"
            "RenderPipeline" = "UniversalPipeline" "UniversalMaterialType" = "Lit"
            "IgnoreProjector" = "True" "ShaderModel" = "4.5"
        }
        // ---------------
        // ForwordLit Pass
        Pass
        {
            // ---------
            // Pass name
            Name "ForwardLit"
            // ---------
            // Pass tags
            Tags
            {
                "LightMode" = "UniversalForward"
            }
            // ----------
            // Test modes
            Cull[_CullMode] ZWrite On ZTest LEqual

            // ---------------
            // HLSL Code Block
            HLSLPROGRAM
            // --------
            // Includes
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            // Custom functions library needs to choose the path of index
            #include "Assets/02.Resources/01.ShaderIncludes/BRDF_Standard.cginc"
            // --------
            // Keywords
            // Mateials
            #pragma vertex LitPassVertex
            #pragma fragment LitPassFragment
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local _ALPHAON
            #pragma shader_feature_local _LIGHTINGCHECK_DIRECTDIFFUSE _LIGHTINGCHECK_DIRECTSPECULAR _LIGHTINGCHECK_INDIRECTDIFFUSE _LIGHTINGCHECK_INDIRECTSPECULAR _LIGHTINGCHECK_DIRECTLIGHTING _LIGHTINGCHECK_INDIRECTLIGHTING _LIGHTINGCHECK_ALL
            #pragma shader_feature_local _DMODE_UE _DMODE_UNITY _DMODE_SP
            // Debug
            #pragma target 4.5
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            // Optimizations
            #pragma exclude_renderers gles gles3 glcore
            // --------------------
            // Vertex Inputs Struct
            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normalOS : NORMAL;
                // Use the model space tangent and the w component save different platforms tangent
                float4 tangentOS : TANGENT;
                float2 texcoord : TEXCOORD0;
            };
            // ---------------------
            // Vertex Outputs Struct
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 positionWS : TEXCOORD1;
                float3 normalWS : TEXCOORD2;
                // xyz: tangent, w: sign
                float4 tangentWS : TEXCOORD3;
                float4 shadowCoord : TEXCOORD4;
            };
            // -------------
            // Vertex Shader
            Varyings LitPassVertex(Attributes input)
            {
                // Initialize Vertex Outputs Struct to 0
                Varyings output = (Varyings)0;
                // Convert model vertex pisition from model space to clip space
                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                // Convert normal direction from model space to world space
                VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);
                // Assign some values to the Vertex Outputs Struct
                output.uv = input.texcoord;
                output.normalWS = normalInput.normalWS;
                // Use the model space tangent.w to judge toward
                real sign = input.tangentOS.w * GetOddNegativeScale();
                // Calculate the world space tangent
                float4 tangentWS = float4(normalInput.tangentWS.xyz, sign);
                output.tangentWS = tangentWS;
                // Calculate the world space vertex postion
                output.positionWS = vertexInput.positionWS;
                // Calculate the shadow coordinates
                output.shadowCoord = GetShadowCoord(vertexInput);
                // Calculate the clip space vertex postion
                output.positionCS = vertexInput.positionCS;
                return output;
            }
            // -----------------
            // Parameter Members
            // Texture Members
            TEXTURE2D(_BaseMap);        SAMPLER(sampler_BaseMap);
            TEXTURE2D(_OpacityMap);     SAMPLER(sampler_OpacityMap);
            TEXTURE2D(_NormalMap);      SAMPLER(sampler_NormalMap);
            TEXTURE2D(_MetallicMap);    SAMPLER(sampler_MetallicMap);
            TEXTURE2D(_RoughnessMap);   SAMPLER(sampler_RoughnessMap);
            TEXTURE2D(_AOMap);          SAMPLER(sampler_AOMap);
            TEXTURE2D(_EmissionMap);    SAMPLER(sampler_EmissionMap);
            // Variables Members
            CBUFFER_START(UnityPerMaterial)
                float4 _BaseColor, _EmissionColor;
                int _CullMode, _ZWrite, _ZTest, _AlphaClip;
                float _Cutoff, _NormalStrength, _MetallicStrength, _RoughnessStrength, _AOStrength;
            CBUFFER_END
            // ---------------
            // Fragment Shader
            float4 LitPassFragment(Varyings input) : SV_Target
            {
                // -----------
                // Input Datas
                float3 viewDir = GetWorldSpaceNormalizeViewDir(input.positionWS);
                float2 textureUV = input.uv;
                float3 worldPosition = input.positionWS.xyz;
                float3 worldNormal = normalize(input.normalWS);
                float3 worldTangent = normalize(input.tangentWS.xyz);
                float3 worldBiTangent = normalize(cross(worldNormal, worldTangent) * input.tangentWS.w);
                float3x3 matrix_TBN = float3x3(worldTangent, worldBiTangent, worldNormal);
                // Calculate the shadow coordinates
                float4 shadowUV = input.shadowCoord;
                #if defined(_MAIN_LIGHT_SHADOWS_SCREEN)
                    float4 positionCS = TransformWorldToHClip(worldPosition);
                    shadowUV = ComputeScreenPos(positionCS);
                #else
                    shadowUV = TransformWorldToShadowCoord(worldPosition);
                #endif
                float4 shadowMask = float4(1.0, 1.0, 1.0, 1.0);
                // ---------------
                // Materials Datas
                // Albedo Map Sampling
                float3 baseAlbedo = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, textureUV).rgb * _BaseColor.rgb;
                // Opacity Map Sampling
                float baseOpacity = SAMPLE_TEXTURE2D(_OpacityMap, sampler_OpacityMap, textureUV).r;
                #ifdef _ALPHAON
                    clip(baseOpacity - _Cutoff);
                #endif
                // Normal Map Sampling
                float3 baseNormalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, textureUV), _NormalStrength);
                worldNormal = normalize(mul(baseNormalTS, matrix_TBN));
                // Metallic Map Sampling
                float baseMetallic = saturate(SAMPLE_TEXTURE2D(_MetallicMap, sampler_MetallicMap, textureUV).r * _MetallicStrength);
                // Roughness Map Sampling
                float baseRoughness = saturate(SAMPLE_TEXTURE2D(_RoughnessMap, sampler_RoughnessMap, textureUV).r * _RoughnessStrength);
                baseRoughness = max(baseRoughness, 0.0001);
                // AO Map Sampling
                float baseAO = SAMPLE_TEXTURE2D(_AOMap, sampler_AOMap, textureUV).r;
                baseAO = lerp(1.0, baseAO, _AOStrength);
                // Emission Map Sampling
                float3 baseEmission = SAMPLE_TEXTURE2D(_EmissionMap, sampler_EmissionMap, textureUV).rgb * _EmissionColor.rgb;
                // ----------
                // BRDF Datas
                // Use the metallic to differentiate albedo
                float3 diffuseColor = lerp(baseAlbedo, 0.001, baseMetallic);
                float3 specularColor = lerp(0.04, baseAlbedo, baseMetallic);
                // --------------------
                // Direct Lighting Part
                // Initialize and Calculate the main light
                float3 directLighting_MainLight = 0.0;
                {
                    // Get the main light's informations
                    Light light = GetMainLight(shadowUV, worldPosition, shadowMask);
                    float3 nDir = worldNormal;
                    float3 vDir = viewDir;
                    float3 lDir = light.direction;
                    float3 lightColor = light.color;
                    // Calculate the main light's shadow attenuation, because of the directional light
                    float shadow = light.shadowAttenuation;
                    directLighting_MainLight = StandardDirectBRDF_UE4(diffuseColor, specularColor, baseRoughness, nDir, vDir, lDir, lightColor, shadow);
                }
                // Initialize and Calculate the additional lights
                float3 directLighting_AddLight = 0.0;
                // Use the macros to judge additional lights
                #ifdef _ADDITIONAL_LIGHTS
                    // Get additional lights numbers
                    uint pixelLightCount = GetAdditionalLightsCount();
                    // Use the for loop to constrain additional lights numbers
                    for (uint lightIndex = 0; lightIndex < pixelLightCount; ++lightIndex)
                    {
                        // Get the additional light's informations
                        Light light = GetAdditionalLight(lightIndex, worldPosition, shadowMask);
                        float3 nDir = worldNormal;
                        float3 vDir = viewDir;
                        float3 lDir = light.direction;
                        float3 lightColor = light.color;
                        // Calculate the main light's shadow attenuation and distance, because of the additional light
                        float shadow = light.shadowAttenuation * light.distanceAttenuation;
                        // Because of the additional lights with the loop accumulate, so use +=
                        directLighting_AddLight += StandardDirectBRDF_UE4(diffuseColor, specularColor, baseRoughness, nDir, vDir, lDir, lightColor, shadow);
                    }
                #endif
                // Results of the direct lighting
                float3 directLighting = directLighting_MainLight + directLighting_AddLight;
                // ----------------------
                // Indirect Lighting Part
                float3 indirectLighting = StandardIndirectBRDF_UE4(diffuseColor, specularColor, baseRoughness, worldPosition, worldNormal, viewDir, baseAO);
                // -------------
                // Final Outputs
                float3 finalColor = directLighting + indirectLighting;
                // Whether to use emissive
                #ifdef _EMISSION
                    finalColor += baseEmission;
                #endif
                return float4(finalColor, 1.0);
            }
            ENDHLSL
        }

        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
            Cull[_CullMode] ZWrite On ZTest LEqual

            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5
            // This is used during shadow map generation to differentiate between directional and punctual light shadows, as they use different formulas to apply Normal Bias
            #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
            #pragma vertex ShadowPassVertex
            #pragma fragment ShadowPassFragment
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/ShadowCasterPass.hlsl"
            ENDHLSL
        }

        Pass
        {
            // ---------
            // Pass name
            Name "DepthOnly"
            // ---------
            // Pass tags
            Tags
            {
                "LightMode" = "DepthOnly"
            }
            ColorMask 0

            // ----------
            // Test modes
            Cull[_CullMode] ZWrite On ZTest LEqual

            // ---------------
            // HLSL Code Block
            HLSLPROGRAM
            // --------
            // Includes
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            // Custom functions library needs to choose the path of index
            #include "Assets/02.Resources/01.ShaderIncludes/BRDF_Standard.cginc"
            // --------
            // Keywords
            // Mateials
            #pragma vertex LitPassVertex
            #pragma fragment LitPassFragment
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local _LIGHTINGCHECK_DIRECTDIFFUSE _LIGHTINGCHECK_DIRECTSPECULAR _LIGHTINGCHECK_INDIRECTDIFFUSE _LIGHTINGCHECK_INDIRECTSPECULAR _LIGHTINGCHECK_DIRECTLIGHTING _LIGHTINGCHECK_INDIRECTLIGHTING _LIGHTINGCHECK_ALL
            #pragma shader_feature_local _DMODE_UE _DMODE_UNITY _DMODE_SP
            // Debug
            #pragma target 4.5
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            // Optimizations
            #pragma exclude_renderers gles gles3 glcore
            // --------------------
            // Vertex Inputs Struct
            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normalOS : NORMAL;
                // Use the model space tangent and the w component save different platforms tangent
                float4 tangentOS : TANGENT;
                float2 texcoord : TEXCOORD0;
            };
            // ---------------------
            // Vertex Outputs Struct
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 positionWS : TEXCOORD1;
                float3 normalWS : TEXCOORD2;
                // xyz: tangent, w: sign
                float4 tangentWS : TEXCOORD3;
                float4 shadowCoord : TEXCOORD4;
            };
            // -------------
            // Vertex Shader
            Varyings LitPassVertex(Attributes input)
            {
                // Initialize Vertex Outputs Struct to 0
                Varyings output = (Varyings)0;
                // Convert model vertex pisition from model space to clip space
                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                // Convert normal direction from model space to world space
                VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);
                // Assign some values to the Vertex Outputs Struct
                output.uv = input.texcoord;
                output.normalWS = normalInput.normalWS;
                // Use the model space tangent.w to judge toward
                real sign = input.tangentOS.w * GetOddNegativeScale();
                // Calculate the world space tangent
                float4 tangentWS = float4(normalInput.tangentWS.xyz, sign);
                output.tangentWS = tangentWS;
                // Calculate the world space vertex postion
                output.positionWS = vertexInput.positionWS;
                // Calculate the shadow coordinates
                output.shadowCoord = GetShadowCoord(vertexInput);
                // Calculate the clip space vertex postion
                output.positionCS = vertexInput.positionCS;
                return output;
            }
            // -----------------
            // Parameter Members
            // Texture Members
            TEXTURE2D(_BaseMap);        SAMPLER(sampler_BaseMap);
            TEXTURE2D(_OpacityMap);     SAMPLER(sampler_OpacityMap);
            TEXTURE2D(_NormalMap);      SAMPLER(sampler_NormalMap);
            TEXTURE2D(_MetallicMap);    SAMPLER(sampler_MetallicMap);
            TEXTURE2D(_RoughnessMap);   SAMPLER(sampler_RoughnessMap);
            TEXTURE2D(_AOMap);          SAMPLER(sampler_AOMap);
            TEXTURE2D(_EmissionMap);    SAMPLER(sampler_EmissionMap);
            // Variables Members
            CBUFFER_START(UnityPerMaterial)
                float4 _BaseColor, _EmissionColor;
                int _CullMode, _ZWrite, _ZTest, _AlphaClip;
                float _Cutoff, _NormalStrength, _MetallicStrength, _RoughnessStrength, _AOStrength;
            CBUFFER_END
            // ---------------
            // Fragment Shader
            float4 LitPassFragment(Varyings input) : SV_Target
            {
                // -----------
                // Input Datas
                float3 viewDir = GetWorldSpaceNormalizeViewDir(input.positionWS);
                float2 textureUV = input.uv;
                float3 worldPosition = input.positionWS.xyz;
                float3 worldNormal = normalize(input.normalWS);
                float3 worldTangent = normalize(input.tangentWS.xyz);
                float3 worldBiTangent = normalize(cross(worldNormal, worldTangent) * input.tangentWS.w);
                float3x3 matrix_TBN = float3x3(worldTangent, worldBiTangent, worldNormal);
                // Calculate the shadow coordinates
                float4 shadowUV = input.shadowCoord;
                #if defined(_MAIN_LIGHT_SHADOWS_SCREEN)
                    float4 positionCS = TransformWorldToHClip(worldPosition);
                    shadowUV = ComputeScreenPos(positionCS);
                #else
                    shadowUV = TransformWorldToShadowCoord(worldPosition);
                #endif
                float4 shadowMask = float4(1.0, 1.0, 1.0, 1.0);
                // ---------------
                // Materials Datas
                // Albedo Map Sampling
                float3 baseAlbedo = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, textureUV).rgb * _BaseColor.rgb;
                // Opacity Map Sampling
                float baseOpacity = SAMPLE_TEXTURE2D(_OpacityMap, sampler_OpacityMap, textureUV).r;
                #ifdef _ALPHAON
                    clip(baseOpacity - _Cutoff);
                #endif
                // Normal Map Sampling
                float3 baseNormalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, textureUV), _NormalStrength);
                worldNormal = normalize(mul(baseNormalTS, matrix_TBN));
                // Metallic Map Sampling
                float baseMetallic = saturate(SAMPLE_TEXTURE2D(_MetallicMap, sampler_MetallicMap, textureUV).r * _MetallicStrength);
                // Roughness Map Sampling
                float baseRoughness = saturate(SAMPLE_TEXTURE2D(_RoughnessMap, sampler_RoughnessMap, textureUV).r * _RoughnessStrength);
                baseRoughness = max(baseRoughness, 0.0001);
                // AO Map Sampling
                float baseAO = SAMPLE_TEXTURE2D(_AOMap, sampler_AOMap, textureUV).r;
                baseAO = lerp(1.0, baseAO, _AOStrength);
                // Emission Map Sampling
                float3 baseEmission = SAMPLE_TEXTURE2D(_EmissionMap, sampler_EmissionMap, textureUV).rgb * _EmissionColor.rgb;
                // ----------
                // BRDF Datas
                // Use the metallic to differentiate albedo
                float3 diffuseColor = lerp(baseAlbedo, 0.001, baseMetallic);
                float3 specularColor = lerp(0.04, baseAlbedo, baseMetallic);
                // --------------------
                // Direct Lighting Part
                // Initialize and Calculate the main light
                float3 directLighting_MainLight = 0.0;
                {
                    // Get the main light's informations
                    Light light = GetMainLight(shadowUV, worldPosition, shadowMask);
                    float3 nDir = worldNormal;
                    float3 vDir = viewDir;
                    float3 lDir = light.direction;
                    float3 lightColor = light.color;
                    // Calculate the main light's shadow attenuation, because of the directional light
                    float shadow = light.shadowAttenuation;
                    directLighting_MainLight = StandardDirectBRDF_UE4(diffuseColor, specularColor, baseRoughness, nDir, vDir, lDir, lightColor, shadow);
                }
                // Initialize and Calculate the additional lights
                float3 directLighting_AddLight = 0.0;
                // Use the macros to judge additional lights
                #ifdef _ADDITIONAL_LIGHTS
                    // Get additional lights numbers
                    uint pixelLightCount = GetAdditionalLightsCount();
                    // Use the for loop to constrain additional lights numbers
                    for (uint lightIndex = 0; lightIndex < pixelLightCount; ++lightIndex)
                    {
                        // Get the additional light's informations
                        Light light = GetAdditionalLight(lightIndex, worldPosition, shadowMask);
                        float3 nDir = worldNormal;
                        float3 vDir = viewDir;
                        float3 lDir = light.direction;
                        float3 lightColor = light.color;
                        // Calculate the main light's shadow attenuation and distance, because of the additional light
                        float shadow = light.shadowAttenuation * light.distanceAttenuation;
                        // Because of the additional lights with the loop accumulate, so use +=
                        directLighting_AddLight += StandardDirectBRDF_UE4(diffuseColor, specularColor, baseRoughness, nDir, vDir, lDir, lightColor, shadow);
                    }
                #endif
                // Results of the direct lighting
                float3 directLighting = directLighting_MainLight + directLighting_AddLight;
                // ----------------------
                // Indirect Lighting Part
                float3 indirectLighting = StandardIndirectBRDF_UE4(diffuseColor, specularColor, baseRoughness, worldPosition, worldNormal, viewDir, baseAO);
                // -------------
                // Final Outputs
                float3 finalColor = directLighting + indirectLighting;
                // Whether to use emissive
                #ifdef _EMISSION
                    finalColor += baseEmission;
                #endif
                return float4(finalColor, 1.0);
            }
            ENDHLSL
        }
    }
}
