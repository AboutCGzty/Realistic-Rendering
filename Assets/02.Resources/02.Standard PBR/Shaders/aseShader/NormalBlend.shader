Shader "Unlit/NormalBlend"
{
    Properties
    {
        [Normal][NoScaleOffset]_Normal1 ("Normal 1", 2D) = "bump" { }
        _Normal1Intensity ("Normal 1 Intensity", Range(0.0, 1.0)) = 1.0
        [Normal][NoScaleOffset]_Normal2 ("Normal 2", 2D) = "bump" { }
        _Normal2Intensity ("Normal 2 Intensity", Range(0.0, 1.0)) = 1.0
        [Toggle(_LINEAR)]_Linear ("LinearBlending", float) = 1.0
        [Toggle(_OVERLAY)]_Overlay ("OverlayBlending", float) = 0.0
        [Toggle(_PD)]_PDBlending ("PDBlending", float) = 0.0
        [Toggle(_WHITEOUT)]_WhiteoutBlending ("WhiteoutBlending", float) = 0.0
        [Toggle(_RNM)]_RNMBlending ("RNMBlending", float) = 0.0
        
        // [KeywordEnum(MODE_LINEAR, MODE_OVERLAY, MODE_PD, MODE_WHITEOUT, MODE_RNM)]_MODE ("Mode", int) = 0

    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }

        Pass
        {
            Tags { "LightMode" = "ForwardBase" }
            // Tags { "LightMode" = "UniversalForwardOnly" }

            // HLSLPROGRAM
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            // #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Core.hlsl"
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma shader_feature_local _LINEAR
            #pragma shader_feature_local _OVERLAY
            #pragma shader_feature_local _PD
            #pragma shader_feature_local _WHITEOUT
            #pragma shader_feature_local _RNM

            // #pragma shader_feature_local MODE_LINEAR MODE_OVERLAY MODE_PD MODE_WHITEOUT MODE_RNM

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 uv_mesh : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv_mesh : TEXCOORD0;
                float3 posWS : TEXCOORD1;
                float3 normal_world : TEXCOORD2;
                float3 tangent_world : TEXCOORD3;
                float3 bitangent_world : TEXCOORD4;
            };

            sampler2D _Normal1, _Normal2;
            float _Normal1Intensity, _Normal2Intensity;

            // TEXTURE2D(_Normal1), SAMPLER(sampler_Normal1);
            // TEXTURE2D(_Normal2), SAMPLER(sampler_Normal2);
            // CBUFFER_START(UnityperMaterial)
            //     float _Normal1Intensity, _Normal2Intensity;
            //     // int _MODE;
            // CBUFFER_END
            
            v2f vert(appdata v)
            {
                v2f o;
                o.uv_mesh = v.uv_mesh;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.normal_world = UnityObjectToWorldNormal(v.normal);
                o.tangent_world = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
                o.bitangent_world = normalize(cross(o.normal_world, o.tangent_world) * v.tangent.w);
                return o;
            }

            //#region BlendNormalFunctions
            float3 NormalBlending_Linear(float3 n1, float3 n2)
            {
                float3 r = (n1 + n2) * 2.0 - 2.0;
                return normalize(r);
            }

            float overlay(float x, float y)
            {
                if (x < 0.5)
                    return 2.0 * x * y;
                else
                    return 1.0 - 2.0 * (1.0 - x) * (1.0 - y);
            }

            float3 NormalBlending_Overlay(float3 n1, float3 n2)
            {
                float3 n;
                n.x = overlay(n1.x, n2.x);
                n.y = overlay(n1.y, n2.y);
                n.z = overlay(n1.z, n2.z);
                return normalize(n * 2.0 - 1.0);
            }

            float3 NormalBlending_PartialDerivative(float3 n1, float3 n2)
            {
                n1 = n1 * 2.0 - 1.0;
                n2 = n2 * 2.0 - 1.0;
                float3 r = normalize(float3(n1.xy * n2.z + n2.xy * n1.z, n1.z * n2.z));
                return r;
            }

            float3 NormalBlending_Whiteout(float3 n1, float3 n2)
            {
                n1 = n1 * 2.0 - 1.0;
                n2 = n2 * 2.0 - 1.0;
                float3 r = float3(n1.xy + n2.xy, n1.z * n2.z);
                return normalize(r);
            }

            float3 NormalBlending_ReorientedNormalMapping(float3 n1, float3 n2)
            {
                // n1 = n1 * float3(2, 2, 2) + float3(-1, -1, 0);
                // n2 = n2 * float3(-2, -2, 2) + float3(1, 1, -1);
                // return n1 * dot(n1, n2) / n1.z - n2;

                n1 += float3(0.0, 0.0, 1.0);
                n2 *= float3(-1.0, -1.0, 1.0);
                float3 r = n1 * dot(n1, n2) / n1.z - n2;
                return normalize(r);
            }
            //#endregion

            float4 frag(v2f i) : SV_Target
            {
                float3x3 TBN = float3x3(i.tangent_world, i.bitangent_world, i.normal_world);
                float3 n1 = UnpackNormalWithScale(tex2D(_Normal1, i.uv_mesh), _Normal1Intensity);
                float3 n2 = UnpackNormalWithScale(tex2D(_Normal2, i.uv_mesh), _Normal2Intensity);
                // float3 n1 = UnpackNormalWithScale(SAMPLE_TEXTURE2D(_Normal1, i.uv_mesh), _Normal1Intensity);
                // float3 n2 = UnpackNormalWithScale(SAMPLE_TEXTURE2D(_Normal2, i.uv_mesh), _Normal2Intensity);

                float3 worldnormal = float3(0.0, 0.0, 1.0);
                float3 normalblend = float3(0.0, 0.0, 1.0);
                #ifdef  _LINEAR
                    normalblend = NormalBlending_Linear(n1, n2);
                    worldnormal = normalize(mul(normalblend, TBN));
                #elif _OVERLAY
                    normalblend = NormalBlending_Overlay(n1, n2);
                    worldnormal = normalize(mul(normalblend, TBN));
                #elif _PD
                    normalblend = NormalBlending_PartialDerivative(n1, n2);
                    worldnormal = normalize(mul(normalblend, TBN));
                #elif _WHITEOUT
                    normalblend = NormalBlending_Whiteout(n1, n2);
                    worldnormal = normalize(mul(normalblend, TBN));
                #elif _RNM
                    normalblend = NormalBlending_ReorientedNormalMapping(n1, n2);
                    worldnormal = normalize(mul(normalblend, TBN));
                #endif

                // float3 vieDir = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float lambert = saturate(dot(worldnormal, lightDir));
                float3 finalcol = lambert * _LightColor0.xyz;

                return float4(finalcol, 1.0);
            }
            ENDCG
            // ENDHLSL

        }
    }
}