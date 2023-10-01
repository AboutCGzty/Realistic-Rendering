Shader "ZTY/PBR/RealisticCharacter/Skin"
{
    Properties
    {
        // ---------------
        //#region 渲染设置
        [Header(Rendering Settings ____________________________________________________________________________________________________________________________________________________________________)]
        [Space(10)]
        [Enum(UnityEngine.Rendering.CullMode)]
        _CullMode ("CullMode", int) = 2
        //#endregion

        // ---------------
        //#region 贴图采样
        [Header(PBR Textures ____________________________________________________________________________________________________________________________________________________________________)]
        [Space(10)]
        [NoScaleOffset]_BaseMap ("Albedo", 2D) = "white" { }
        [NoScaleOffset]_LutMap ("Lut", 2D) = "gray" { }
        [Normal][NoScaleOffset]_NormalMap ("Normal", 2D) = "bump" { }
        [NoScaleOffset]_SpecularMap ("Specular", 2D) = "black" { }
        [NoScaleOffset]_RoughnessMap ("Roughness", 2D) = "white" { }
        [NoScaleOffset]_AOMap ("AO", 2D) = "white" { }
        [Header((Details))]
        [Space(10)]
        [Normal][NoScaleOffset]_DetailNormalMap ("Detail Normal", 2D) = "bump" { }
        [NoScaleOffset]_DetailNormalMask ("Detail Normal Mask", 2D) = "black" { }
        _DetailNormalTilling ("Detail Normal Tilling", float) = 15.0
        _DetailNormalStrength ("Detail Normal Strength", Range(0.0, 1.0)) = 0.5
        
        [Header((ClearCoat))]
        [Space(10)]
        [NoScaleOffset]_ClearCoatMask ("ClearCoat Mask", 2D) = "black" { }
        _ClearCoatStrength ("ClearCoat Strength", Range(0.0, 1.0)) = 0.0
        _ClearCoatRoughness ("ClearCoat Roughness", Range(0.0, 1.0)) = 0.5
        //#endregion

        // ---------------
        //#region 变量参数
        [Header(Variable Members ____________________________________________________________________________________________________________________________________________________________________)]
        [Header((Color))]
        [Space(10)]
        _BaseColor ("Base Color", Color) = (1.0, 1.0, 1.0, 0.0)
        _DiffuseShadowColor ("DiffuseShadow Color", Color) = (0.0, 0.0, 0.0, 0.0)
        _ShadowAdd ("Shadow Add", Range(0.0, 1.0)) = 0.2
        [Header((Bump))]
        [Space(10)]
        _NormalStrength ("Normal Strength", Range(0.0, 1.0)) = 1.0
        [Header((Reflection))]
        [Space(10)]
        _SSSRange ("SSS Range", Range(0.0, 1.0)) = 0.5
        _SSSPower ("SSS Power", Range(1.0, 10.0)) = 1.0
        // _LutBlur_G ("LutBlur G", Range(0.01, 0.5)) = 0.2
        // _LutBlur_B ("LutBlur B", Range(0.5, 1.0)) = 0.6
        _SpecularStrength ("Specular Strength", Range(0.0, 1.0)) = 0.5
        _Roughness0Strength ("Roughness0 Strength", Range(0.0, 1.0)) = 0.4
        _Roughness1Strength ("Roughness1 Strength", Range(0.0, 1.0)) = 0.6
        _RoughnessMix ("Roughness1 Mix", Range(0.0, 1.0)) = 0.5
        _AOStrength ("AO Strength", Range(0.0, 1.0)) = 1.0
        //#endregion

        // ------------
        //#region Debug
        [Header(Debug Mode ____________________________________________________________________________________________________________________________________________________________________)]
        [Header((Color))]
        [Header(Normal need Mipmap)]
        [Space(5)]
        [Toggle(_SSS)]_SSS ("SSS", int) = 1
        [Toggle(_DETAILON)]_DETAILON ("Detail", int) = 1
        [Header(Lighting Debug ____________________________________________________________________________________________________________________________________________________________________)]
        [Header((Direct Diffuse))]
        [Space(10)]
        [Toggle(_DIRECTDIFFUSE)]_DIRECTDIFFUSE ("Direct Diffuse", int) = 1
        _DirectDiffuseStrength ("Direct Diffuse Strength", Range(0.0, 1.0)) = 1.0
        [Header((Direct Specular))]
        [Space(10)]
        [Toggle(_DIRECTSPECULAR)]_DIRECTSPECULAR ("Direct Specular", int) = 1
        _DirectSpecularStrength ("Direct Specular Strength", Range(0.0, 1.0)) = 1.0
        [Header((Indirect Diffuse))]
        [Space(10)]
        [Toggle(_INDIRECTDIFFUSE)]_INDIRECTDIFFUSE ("Indirect Diffuse", int) = 1
        _IndirectDiffuseStrength ("Indirect Diffuse Strength", Range(0.0, 1.0)) = 1.0
        [Header((Indirect Specular))]
        [Space(10)]
        [Toggle(_INDIRECTSPECULAR)]_INDIRECTSPECULAR ("Indirect Specular", int) = 1
        _IndirectSpecularStrength ("Indirect Specular Strength", Range(0.0, 1.0)) = 1.0
        [Header((Clear Coat))]
        [Space(10)]
        [Toggle(_CLEARCOAT)]_CLEARCOAT ("Clear Coat", int) = 1
        _IndirectRotation ("Indirect Rotation", Range(0.0, 360.0)) = 1.0
        //#endregion

    }

    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
            "RenderPipeline" = "UniversalPipeline" "UniversalMaterialType" = "Lit"
            "IgnoreProjector" = "True" "ShaderModel" = "4.5"
        }
        LOD 300

        Pass
        {
            Name "ForwardLit"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
            Cull[_CullMode] ZWrite On ZTest LEqual

            HLSLPROGRAM
            // ----------------
            //#region 引入头文�?
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Assets/02.Resources/01.ShaderIncludes/BRDF_Skin.cginc"
            //#endregion

            // -----------------
            //#region 定义关键�?
            // --------
            // 材质相关
            #pragma vertex LitPassVertex
            #pragma fragment LitPassFragment
            #pragma shader_feature_local _SSS
            #pragma shader_feature_local _DETAILON
            #pragma shader_feature_local _DIRECTDIFFUSE
            #pragma shader_feature_local _DIRECTSPECULAR
            #pragma shader_feature_local _INDIRECTDIFFUSE
            #pragma shader_feature_local _INDIRECTSPECULAR
            #pragma shader_feature_local _CLEARCOAT
            // --------
            // 管线相关
            #pragma target 4.5
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            // --------
            // 优化相关
            #pragma exclude_renderers gles gles3 glcore
            //#endregion

            // --------------------
            //#region 顶点输入结构�?
            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normalOS : NORMAL;
                // ---------------------------------------------
                // 模型空间切线信息，w分量存储的是不同平台的切线朝�?
                float4 tangentOS : TANGENT;
                float2 texcoord : TEXCOORD0;
            };
            //#endregion

            // --------------------
            //#region 顶点输出结构�?
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 positionWS : TEXCOORD1;
                float3 normalWS : TEXCOORD2;
                // ---------------------
                // xyz: tangent, w: sign
                float4 tangentWS : TEXCOORD3;
                float4 shadowCoord : TEXCOORD4;
            };
            //#endregion

            // -----------------
            //#region 顶点Shader
            Varyings LitPassVertex(Attributes input)
            {
                // 将输出结构体中的所有成员初始化�? 0
                Varyings output = (Varyings)0;
                // 将顶点坐标由模型空间转换至齐次裁剪空�?
                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                // 将法线由模型空间转换至世界空�?
                VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);
                // 给输出结构体赋�?
                output.uv = input.texcoord;
                output.normalWS = normalInput.normalWS;
                // 通过模型空间切线的w分量判断朝向
                real sign = input.tangentOS.w * GetOddNegativeScale();
                float4 tangentWS = float4(normalInput.tangentWS.xyz, sign);
                output.tangentWS = tangentWS;
                output.positionWS = vertexInput.positionWS;
                output.shadowCoord = GetShadowCoord(vertexInput);
                output.positionCS = vertexInput.positionCS;
                return output;
            }
            //#endregion

            // ---------------
            //#region 参数成员
            // --------
            // 纹理成员
            TEXTURE2D(_BaseMap);            SAMPLER(sampler_BaseMap);
            TEXTURE2D(_LutMap);             SAMPLER(sampler_LutMap);
            TEXTURE2D(_NormalMap);          SAMPLER(sampler_NormalMap);
            TEXTURE2D(_DetailNormalMap);    SAMPLER(sampler_DetailNormalMap);
            TEXTURE2D(_DetailNormalMask);   SAMPLER(sampler_DetailNormalMask);
            TEXTURE2D(_ClearCoatMask);      SAMPLER(sampler_ClearCoatMask);
            TEXTURE2D(_SpecularMap);        SAMPLER(sampler_SpecularMap);
            TEXTURE2D(_RoughnessMap);       SAMPLER(sampler_RoughnessMap);
            TEXTURE2D(_AOMap);              SAMPLER(sampler_AOMap);
            // --------
            // 变量成员
            CBUFFER_START(UnityPerMaterial)
                float4 _BaseColor, _DiffuseShadowColor;
                int _CullMode, _ZWrite, _ZTest;
                float _DirectDiffuseStrength, _DirectSpecularStrength, _IndirectDiffuseStrength, _IndirectSpecularStrength, _IndirectRotation;
                float _NormalStrength, _DetailNormalTilling, _DetailNormalStrength, _SpecularStrength, _ClearCoatStrength, _ClearCoatRoughness, _Roughness0Strength, _Roughness1Strength, _RoughnessMix, _AOStrength, _SSSRange, _SSSPower, _ShadowAdd;
            CBUFFER_END
            //#endregion



            // -----------------
            //#region 片元Shader
            float4 LitPassFragment(Varyings input) : SV_Target
            {
                // ------------------
                //#region 输入数据计算
                float3 viewDir = GetWorldSpaceNormalizeViewDir(input.positionWS);
                float2 textureUV = input.uv;
                float3 worldPosition = input.positionWS.xyz;
                float3 worldNormal = normalize(input.normalWS);
                float3 worldTangent = normalize(input.tangentWS.xyz);
                float3 worldBiTangent = normalize(cross(worldNormal, worldTangent) * input.tangentWS.w);
                float3x3 matrix_TBN = float3x3(worldTangent, worldBiTangent, worldNormal);
                // -----------
                // 计算阴影坐标
                float4 shadowUV = input.shadowCoord;
                #if defined(_MAIN_LIGHT_SHADOWS_SCREEN)
                    float4 positionCS = TransformWorldToHClip(worldPosition);
                    shadowUV = ComputeScreenPos(positionCS);
                #else
                    shadowUV = TransformWorldToShadowCoord(worldPosition);
                #endif
                float4 shadowMask = float4(1.0, 1.0, 1.0, 1.0);
                // float2 screenUV = GetNormalizedScreenSpaceUV(input.positionCS);
                //#endregion

                // ------------------
                //#region 材质相关数据
                // -------------
                // 采样反射率贴�?
                float3 baseAlbedo = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, textureUV).rgb * _BaseColor.rgb;
                // -------------------------------------------------
                // 采样【法线贴图】，并使�? TBN矩阵 修改世界空间法线信息
                float3 baseNormalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, textureUV), _NormalStrength);
                float3 baseNormalTS_Mip = UnpackNormalScale(SAMPLE_TEXTURE2D_LOD(_NormalMap, sampler_NormalMap, textureUV, 4), _NormalStrength);
                // ------------------
                // 采样【细节法线贴图�?
                float3 detailNormalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_DetailNormalMap, sampler_DetailNormalMap, textureUV * _DetailNormalTilling), _DetailNormalStrength);
                float3 detailNormalTS_Mip = UnpackNormalScale(SAMPLE_TEXTURE2D_LOD(_DetailNormalMap, sampler_DetailNormalMap, textureUV * _DetailNormalTilling, 4), _DetailNormalStrength);
                // 采样【细节法线遮罩贴图】修改原生法线贴�?
                float detailNormalMask = SAMPLE_TEXTURE2D(_DetailNormalMask, sampler_DetailNormalMask, textureUV).r;
                #ifdef _DETAILON
                    baseNormalTS = NormalBlending_ReorientedNormalMapping(baseNormalTS * detailNormalMask, detailNormalTS);
                    baseNormalTS = lerp(baseNormalTS, detailNormalTS, 1 - detailNormalMask);
                    baseNormalTS_Mip = NormalBlending_ReorientedNormalMapping(baseNormalTS_Mip * detailNormalMask, detailNormalTS_Mip);
                    baseNormalTS_Mip = lerp(baseNormalTS_Mip, detailNormalTS_Mip, 1 - detailNormalMask);
                #endif
                float clearCoatMask = SAMPLE_TEXTURE2D(_ClearCoatMask, sampler_ClearCoatMask, textureUV).r;
                clearCoatMask *= _ClearCoatStrength;
                // 将修改后的法线转换至世界空间
                worldNormal = normalize(mul(baseNormalTS, matrix_TBN));
                float3 worldNormal_Mip = normalize(mul(baseNormalTS_Mip, matrix_TBN));
                float3 worldNormal_ClearCoat = normalize(mul(float3(0.0, 0.0, 1.0), matrix_TBN));

                // ----------------
                // 采样【金属度贴图�?
                float3 baseSpecular = saturate(SAMPLE_TEXTURE2D(_SpecularMap, sampler_SpecularMap, textureUV).rgb * _SpecularStrength);
                // ----------------
                // 采样【粗糙度贴图�?
                float baseRoughness = SAMPLE_TEXTURE2D(_RoughnessMap, sampler_RoughnessMap, textureUV).r;
                float baseRoughness0 = max(baseRoughness * _Roughness0Strength, 0.01);
                float baseRoughness1 = max(baseRoughness * _Roughness1Strength, 0.01);
                // -------------
                // 采样【AO贴图�?
                float baseAO = SAMPLE_TEXTURE2D(_AOMap, sampler_AOMap, textureUV).r;
                baseAO = lerp(1.0, baseAO, _AOStrength);
                //#endregion

                // -------------------
                //#region BRDF相关数据
                // -------------------------------------------------
                // 使用金属度区分【金�?/非金属】的【漫反射/镜面反射】颜�?
                float3 diffuseColor = baseAlbedo;
                float3 specularColor = baseSpecular * 0.08;
                //#endregion

                // ----------------
                //#region 直接光部�?
                // ----------
                // 主光源计�?
                // 初始化主光源
                float3 directLighting_MainLight = 0.0;
                {
                    // -----------------------------
                    // 使用内置方法获取主光源的各种信息
                    Light light = GetMainLight(shadowUV, worldPosition, shadowMask);
                    float3 nDir = worldNormal;
                    float3 vDir = viewDir;
                    float3 lDir = light.direction;
                    float3 lightColor = light.color;
                    // ----------------------------------------
                    // 因为主光源（平行光），所以只需要考虑阴影衰减
                    float shadow = saturate(light.shadowAttenuation + _ShadowAdd);
                    // -----------------------
                    // hard code 自定义阴影颜�?
                    float3 diffuseShadowColor = lerp(_DiffuseShadowColor.rgb, float3(1.0, 1.0, 1.0), shadow);
                    // ----------------------------------
                    // 使用 NL�? Curvature 采样预积分Lut�?
                    float lut_Curvature = GetCurvature(_SSSRange, _SSSPower, nDir, worldPosition);
                    // -----------
                    // 未模糊的Lut
                    float2 lutUV = float2(dot(worldNormal, lDir) * 0.5 + 0.5, lut_Curvature);
                    float3 baseLut = SAMPLE_TEXTURE2D(_LutMap, sampler_LutMap, lutUV).rbg;
                    #ifdef _SSS
                        // ------------------
                        //#region 模糊后的 Lut
                        float NoL = dot(nDir, lDir) * 0.5 + 0.5;
                        float blur_NoL = dot(worldNormal_Mip, lDir) * 0.5 + 0.5;
                        // ---------------
                        // 红色通道取模糊后
                        float2 lutUV_R = float2(blur_NoL, lut_Curvature);
                        float3 baseLut_R = SAMPLE_TEXTURE2D(_LutMap, sampler_LutMap, lutUV_R).rbg;
                        // -----------------------
                        // 绿色通道 lerp(0.1 - 0.5)
                        float2 lutUV_G = float2(lerp(blur_NoL, NoL, 0.2), lut_Curvature);
                        float3 baseLut_G = SAMPLE_TEXTURE2D(_LutMap, sampler_LutMap, lutUV_G).rbg;
                        // -----------------------
                        // 蓝色通道 lerp(0.5 - 0.8)
                        float2 lutUV_B = float2(lerp(blur_NoL, NoL, 0.6), lut_Curvature);
                        float3 baseLut_B = SAMPLE_TEXTURE2D(_LutMap, sampler_LutMap, lutUV_B).rbg;
                        // 最后组合并取平均�?
                        baseLut = (baseLut_R + baseLut_G + baseLut_B) / 3;
                        //#endregion
                    #endif
                    directLighting_MainLight = SkinDirectBRDF_UE4(diffuseColor, diffuseShadowColor, specularColor, clearCoatMask, max(_ClearCoatRoughness, 0.01), worldNormal_ClearCoat, baseRoughness0, baseRoughness1, _RoughnessMix, nDir, vDir, lDir, lightColor, shadow, baseLut, _DirectDiffuseStrength, _DirectSpecularStrength);
                }
                // -----------
                // 附加光源计算
                // 初始化附加光�?
                float3 directLighting_AddLight = 0.0;
                // ----------------------------
                // 使用宏判断是否开启多个附加光�?
                #ifdef _ADDITIONAL_LIGHTS
                    // -----------------
                    // 获取附加光源的数�?
                    uint pixelLightCount = GetAdditionalLightsCount();
                    // ----------------------------
                    // 使用 for循环限制附加光源的数�?
                    for (uint lightIndex = 0; lightIndex < pixelLightCount; ++lightIndex)
                    {
                        // -------------------------------
                        // 使用内置方法获取附加光源的各种信�?
                        Light light = GetAdditionalLight(lightIndex, worldPosition, shadowMask);
                        float3 nDir = worldNormal;
                        float3 vDir = viewDir;
                        float3 lDir = light.direction;
                        float3 lightColor = light.color;
                        // --------------------------------------------
                        // 因为附加光源（点光源），所以是需要增加距离衰减�?
                        float shadow = saturate(light.shadowAttenuation + _ShadowAdd) * light.distanceAttenuation;
                        // -----------------------
                        // hard code 自定义阴影颜�?
                        // float3 diffuseShadowColor = lerp(float3(0.11, 0.025, 0.012), float3(1.0, 1.0, 1.0), shadow);
                        float3 diffuseShadowColor = lerp(_DiffuseShadowColor.rgb, float3(1.0, 1.0, 1.0), shadow);
                        
                        // 使用 NL�? Curvature 采样预积分Lut�?
                        float lut_Curvature = GetCurvature(_SSSRange, _SSSPower, nDir, worldPosition);
                        // -----------
                        // 未模糊的Lut
                        float2 lutUV = float2(dot(worldNormal, lDir) * 0.5 + 0.5, lut_Curvature);
                        float3 baseLut = SAMPLE_TEXTURE2D(_LutMap, sampler_LutMap, lutUV).rbg;
                        #ifdef _SSS
                            // ------------------
                            //#region 模糊后的 Lut
                            float NoL = dot(nDir, lDir) * 0.5 + 0.5;
                            float blur_NoL = dot(worldNormal_Mip, lDir) * 0.5 + 0.5;
                            // ---------------
                            // 红色通道取模糊后
                            float2 lutUV_R = float2(blur_NoL, lut_Curvature);
                            float3 baseLut_R = SAMPLE_TEXTURE2D(_LutMap, sampler_LutMap, lutUV_R).rbg;
                            // -----------------------
                            // 绿色通道 lerp(0.1 - 0.5)
                            float2 lutUV_G = float2(lerp(blur_NoL, NoL, 0.2), lut_Curvature);
                            float3 baseLut_G = SAMPLE_TEXTURE2D(_LutMap, sampler_LutMap, lutUV_G).rbg;
                            // -----------------------
                            // 蓝色通道 lerp(0.5 - 0.8)
                            float2 lutUV_B = float2(lerp(blur_NoL, NoL, 0.6), lut_Curvature);
                            float3 baseLut_B = SAMPLE_TEXTURE2D(_LutMap, sampler_LutMap, lutUV_B).rbg;
                            // 最后组合并取平均�?
                            baseLut = (baseLut_R + baseLut_G + baseLut_B) / 3;
                            //#endregion
                        #endif
                        // -----------------------
                        // 因为是循环累加，所以是 +=
                        directLighting_AddLight += SkinDirectBRDF_UE4(diffuseColor, diffuseShadowColor, specularColor, clearCoatMask, max(_ClearCoatRoughness, 0.01), worldNormal_ClearCoat, baseRoughness0, baseRoughness1, _RoughnessMix, nDir, vDir, lDir, lightColor, shadow, baseLut, _DirectDiffuseStrength, _DirectSpecularStrength);
                    }
                #endif
                // 直接光结�?
                float3 directLighting = directLighting_MainLight + directLighting_AddLight;
                //#endregion

                // ----------------
                //#region 间接光部�?
                float3 indirectLighting = SkinIndirectBRDF_UE4(diffuseColor, specularColor, clearCoatMask, max(_ClearCoatRoughness, 0.01), worldNormal_ClearCoat, baseRoughness0, baseRoughness1, _RoughnessMix, worldPosition, worldNormal, viewDir, baseAO, _IndirectRotation, _IndirectDiffuseStrength, _IndirectSpecularStrength);
                //#endregion

                // ---------------
                //#region 最终输�?
                float3 finalColor = directLighting + indirectLighting;
                //#endregion

                return float4(finalColor, 1.0);
            }
            //#endregion
            ENDHLSL
        }

        //#region ShadowCaster Pass
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
        //#endregion

        //#region DepthOnly Pass
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }
            Cull[_CullMode] ZWrite On ZTest LEqual

            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5

            #pragma vertex DepthOnlyVertex
            #pragma fragment DepthOnlyFragment

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/DepthOnlyPass.hlsl"
            ENDHLSL
        }
        //#endregion

        //#region DepthNormals Pass
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }
            Cull[_CullMode] ZWrite On ZTest LEqual

            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5

            #pragma vertex DepthNormalsVertex
            #pragma fragment DepthNormalsFragment

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitDepthNormalsPass.hlsl"
            ENDHLSL
        }
        //#endregion

    }
}

