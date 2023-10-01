Shader "ZTY/PBR/RealisticCharacter/Eye"
{
    Properties
    {
        // ---------------
        //#region 渲染设置
        [Header(Rendering Settings ____________________________________________________________________________________________________________________________________________________________________)]
        [Space(10)]
        [Enum(UnityEngine.Rendering.CullMode)]
        _CullMode ("CullMode", int) = 2
        [Toggle]_ZWrite ("ZWrite", int) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)]
        _ZTest ("ZTest", int) = 4
        //#endregion

        // ---------------
        //#region 贴图采样
        [Header((Sclera ____________________________________________________________________________________________________________________________________________________________________))]
        [Space(10)]
        _ScleraColor ("Sclera Color", Color) = (1.0, 1.0, 1.0, 0.0)
        _ScleraTilling ("Sclera Tilling", float) = 1.0
        [NoScaleOffset] _ScleraMap ("Sclera", 2D) = "white" { }
        [Normal][NoScaleOffset] _ScleraNormalMap ("Sclera Normal", 2D) = "bump" { }
        _ScleraNormalStrength ("Sclera Normal Strength", Range(0.0, 1.0)) = 1.0
        _ScleraSpecular ("Sclera Specular", Range(0.0, 1.0)) = 0.25
        _ScleraRoughness ("Sclera Roughness", Range(0.0, 1.0)) = 0.15
        [Header((SSS))]
        [Space(10)]
        [NoScaleOffset] _SSSLutMap ("SSS Lut", 2D) = "gray" { }
        [Header((Iris ____________________________________________________________________________________________________________________________________________________________________))]
        [Space(10)]
        _IrisColor ("Iris Color", Color) = (1.0, 1.0, 1.0, 0.0)
        [NoScaleOffset] _IrisMap ("Iris", 2D) = "white" { }
        [Normal][NoScaleOffset] _IrisNormalMap ("Iris Normal", 2D) = "bump" { }
        _IrisNormalStrength ("Iris Normal Strength", Range(0.0, 1.0)) = 1.0
        [NoScaleOffset] _IrisHeightMap ("Iris Height", 2D) = "white" { }
        [Normal][NoScaleOffset] _ViewDirectionNormalMap ("View Direction Normal", 2D) = "bump" { }
        _IrisRadius ("Iris Radius", Range(0.0, 0.5)) = 0.0
        _PupilScale ("Pupil Scale", float) = 1.0
        _IrisDepthScale ("Iris Depth Scale", float) = 1.0
        _IOR ("IOR", float) = 1.45
        [Header((Cornea))]
        [Space(10)]
        _CorneaSpecular ("Cornea Specular", Range(0.0, 1.0)) = 0.5
        _CorneaRoughness ("Cornea Roughness", Range(0.0, 1.0)) = 0.05
        [Header((Caustic))]
        [Space(10)]
        _CausticScale ("Caustic Scale", float) = 2.0
        _CausticPower ("Caustic Power", Range(0.1, 0.5)) = 0.1
        [Header((Limbus))]
        [Space(10)]
        _LimbusScale ("Limbus Scale", float) = 2.0
        _LimbusPower ("Limbus Power", Range(1.0, 5.0)) = 1.0
        //#endregion

        //-------------
        //#region Debug
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
            #include "Assets/02.Resources/01.ShaderIncludes/BRDF_Eye.cginc"
            //#endregion
            // -----------------
            //#region 定义关键�?
            // ---------------
            //#region 材质相关
            #pragma shader_feature_local _DIRECTDIFFUSE
            #pragma shader_feature_local _DIRECTSPECULAR
            #pragma shader_feature_local _INDIRECTDIFFUSE
            #pragma shader_feature_local _INDIRECTSPECULAR
            //#endregion
            // ---------------
            //#region 管线相关
            #pragma target 4.5
            #pragma vertex LitPassVertex
            #pragma fragment LitPassFragment
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            //#endregion
            // ---------------
            //#region 优化相关
            #pragma exclude_renderers gles gles3 glcore
            //#endregion
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
            TEXTURE2D(_ScleraMap);              SAMPLER(sampler_ScleraMap);
            TEXTURE2D(_IrisMap);                SAMPLER(sampler_IrisMap);
            TEXTURE2D(_SSSLutMap);              SAMPLER(sampler_SSSLutMap);
            TEXTURE2D(_IrisHeightMap);          SAMPLER(sampler_IrisHeightMap);
            TEXTURE2D(_ViewDirectionNormalMap); SAMPLER(sampler_ViewDirectionNormalMap);
            TEXTURE2D(_ScleraNormalMap);        SAMPLER(sampler_ScleraNormalMap);
            TEXTURE2D(_IrisNormalMap);          SAMPLER(sampler_IrisNormalMap);
            // --------
            // 变量成员
            CBUFFER_START(UnityPerMaterial)
                float4 _ScleraColor, _IrisColor;
                int _CullMode, _ZWrite, _ZTest;
                float _ScleraTilling, _PupilScale, _IrisRadius, _IOR, _IrisDepthScale, _LimbusScale, _LimbusPower, _ScleraSpecular, _ScleraNormalStrength, _CorneaSpecular, _ScleraRoughness, _CorneaRoughness;
                float _CausticScale, _CausticPower, _IrisNormalStrength, _IndirectRotation, _DirectDiffuseStrength, _DirectSpecularStrength, _IndirectDiffuseStrength, _IndirectSpecularStrength;
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

                // ---------------
                //#region 巩膜部分
                // -------------
                // 采样【巩膜贴图�?
                float2 scleraUV = UVScaleByCenter(textureUV, _ScleraTilling);
                float3 baseSclera = SAMPLE_TEXTURE2D(_ScleraMap, sampler_ScleraMap, scleraUV).rgb * _ScleraColor.rgb;
                //#endregion

                // -------------------------
                //#region 虹膜部分【包含瞳孔�?
                // ----------------------
                // 采样【虹膜折射高度贴图�?
                float irisHeight1 = SAMPLE_TEXTURE2D(_IrisHeightMap, sampler_IrisHeightMap, textureUV).r;
                float irisHeight2 = SAMPLE_TEXTURE2D(_IrisHeightMap, sampler_IrisHeightMap, float2((_ScleraTilling * _IrisRadius) + 0.5, 0.5)).r;
                // ---------------
                // 计算虹膜的深度�?
                float irisDepth = max(0.0001, (irisHeight1 - irisHeight2)) * _IrisDepthScale;
                // ----------------------
                // 采样【虹膜法线朝向贴图�?
                float3 irisNormal = UnpackNormal(SAMPLE_TEXTURE2D(_ViewDirectionNormalMap, sampler_ViewDirectionNormalMap, textureUV)).rgb;
                irisNormal = normalize(mul(irisNormal, matrix_TBN));
                // ---------------
                // 计算虹膜向内折射
                float2 irisRefraction = EyeRefraction(scleraUV, worldNormal, viewDir, _IOR, _IrisRadius, irisDepth, irisNormal, worldTangent).xy;
                // ---------------
                // 采样【虹膜贴图�?
                float2 irisUV = UVScaleByCircle(irisRefraction, _PupilScale);
                float3 baseIris = SAMPLE_TEXTURE2D(_IrisMap, sampler_IrisMap, irisUV).rgb * _IrisColor.rgb;
                // -----------------
                // 计算角膜缘所占区�?
                float limbusMask = pow(saturate(length((irisUV - float2(0.5, 0.5)) * _LimbusScale)), _LimbusPower);
                limbusMask = saturate(1.0 - limbusMask);
                // --------------------------
                // 乘以虹膜颜色得到角膜缘的颜色
                baseIris *= limbusMask;
                //#endregion

                // -------------------------------
                //#region 计算巩膜+虹膜+角膜缘的结果
                // -------------------
                // 计算虹膜所占区域大�?
                float irisMask = (/*求UV边界到中心点距离*/length(scleraUV - float2(0.5, 0.5)) - /*减去虹膜的半径得到遮罩大�?*/_IrisRadius + 0.045) / /*再除以一个值得到虚化的边界*/0.045;
                irisMask = smoothstep(0.0, 1.0, (1.0 - irisMask));
                // -------------------
                // 混合巩膜与虹膜的结果
                float3 basecolor = lerp(baseSclera, baseIris, irisMask);
                //#endregion

                // ---------------
                //#region 法线计算
                // ----------------------------------------------
                // 采样【巩膜法线贴图】，并使�? TBN矩阵 转换世界空间
                float3 baseScleraNormalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_ScleraNormalMap, sampler_ScleraNormalMap, scleraUV), _ScleraNormalStrength).rgb;
                float3 baseScleraNormalWS = lerp(baseScleraNormalTS, float3(0.0, 0.0, 1.0), irisMask);
                baseScleraNormalWS = normalize(mul(baseScleraNormalWS, matrix_TBN));

                // ------------
                // 计算焦散区域
                float concavityMask = EyeRefraction(scleraUV, worldNormal, viewDir, _IOR, _IrisRadius, irisDepth, irisNormal, worldTangent).z;
                concavityMask = saturate(pow((concavityMask * _CausticScale), _CausticPower)) * irisMask;
                // ------------
                // 计算焦散法线
                float3 cuasticNormal = normalize(lerp(irisNormal, -baseScleraNormalWS, concavityMask));
                // ----------------------------------------------
                // 采样【虹膜法线贴图】，并使�? TBN矩阵 转换世界空间
                float2 irisNormalUV = UVScaleByCircle(irisUV, _PupilScale);
                float3 baseIrisNormalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_IrisNormalMap, sampler_IrisNormalMap, irisUV), _IrisNormalStrength).rgb;
                baseIrisNormalTS = normalize(mul(baseIrisNormalTS, matrix_TBN));
                // -----------------------------------------
                // 将视线方向与虹膜表面法线混合得到新的虹膜法线
                float3 irisNormalWS = NormalBlend(baseIrisNormalTS, irisNormal);
                //#endregion

                // ------------------
                //#region 材质相关数据
                // ----------
                // 计算粗糙�?
                float roughnessMask = lerp(_ScleraRoughness, _CorneaRoughness, irisMask);
                roughnessMask = max(0.001, roughnessMask);
                float baseRoughness = roughnessMask;
                //#endregion

                // -------------------
                //#region BRDF相关数据
                // -------------------------------------------------
                // 使用金属度区分【金�?/非金属】的【漫反射/镜面反射】颜�?
                float3 diffuseColor = basecolor;
                float specularMask = lerp(_ScleraSpecular, _CorneaSpecular, irisMask);
                float3 specularColor = float3(specularMask, specularMask, specularMask);
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
                    float shadow = light.shadowAttenuation;
                    // --------------
                    // 采样【SSS贴图�?
                    float2 sssUV = float2(dot(nDir, lDir) * 0.5 + 0.5, 0.9);
                    float3 sssLut = SAMPLE_TEXTURE2D(_SSSLutMap, sampler_SSSLutMap, sssUV).rgb;
                    directLighting_MainLight = EyeDirectBRDF_UE4(diffuseColor, specularColor, baseRoughness, nDir, vDir, lDir, irisMask, irisNormalWS, cuasticNormal, lightColor, shadow, sssLut, _DirectDiffuseStrength, _DirectSpecularStrength);
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
                        float shadow = light.shadowAttenuation * light.distanceAttenuation;
                        // --------------
                        // 采样【SSS贴图�?
                        float2 sssUV = float2(dot(nDir, lDir) * 0.5 + 0.5, 0.9);
                        float3 sssLut = SAMPLE_TEXTURE2D(_SSSLutMap, sampler_SSSLutMap, sssUV).rgb;
                        // -----------------------
                        // 因为是循环累加，所以是 +=
                        directLighting_AddLight += EyeDirectBRDF_UE4(diffuseColor, specularColor, baseRoughness, nDir, vDir, lDir, irisMask, irisNormalWS, cuasticNormal, lightColor, shadow, sssLut, _DirectDiffuseStrength, _DirectSpecularStrength);
                    }
                #endif
                // 直接光结�?
                float3 directLighting = directLighting_MainLight + directLighting_AddLight;
                //#endregion

                // ----------------
                //#region 间接光部�?
                float3 indirectLighting = EyesIndirectBRDF_UE4(diffuseColor, specularColor, baseRoughness, worldPosition, baseScleraNormalWS, viewDir, 1.0, _IndirectRotation, _IndirectDiffuseStrength, _IndirectSpecularStrength);
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
            ColorMask 0

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
            ColorMask 0

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
