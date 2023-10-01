// Made with Amplify Shader Editor v1.9.2.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "UEPBR"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Header(_________________________________________________________________________________________________)][Header(Rendering Settings)][Enum(UnityEngine.Rendering.CullMode)][Space(10)]_CullMode("Cull Mode", Int) = 2
		[Toggle]_ZWrite("ZWrite", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTest("ZTest", Int) = 0
		[Header(_________________________________________________________________________________________________)][Header(Texture Inputs)][Header((Base Map))][NoScaleOffset][SingleLineTexture][Space(10)]_Albedo("Albedo", 2D) = "white" {}
		[NoScaleOffset][Normal][SingleLineTexture]_Normal("Normal", 2D) = "bump" {}
		[NoScaleOffset][SingleLineTexture]_MRA("MRA", 2D) = "white" {}
		[HDR][NoScaleOffset][SingleLineTexture]_Emission("Emission", 2D) = "white" {}
		[Header((UVs))][Space(10)]_TillingandOffset("Tilling and Offset", Vector) = (0,0,0,0)
		[Toggle(_USEUVSROTATION_ON)] _UseUVsRotation("Use UVs Rotation", Float) = 0
		_RotationCenterX("Rotation Center X", Float) = 0
		_RotationCenterY("Rotation Center Y", Float) = 0
		_RotationAngle("Rotation Angle", Range( 0 , 1)) = 0
		[Header(_________________________________________________________________________________________________)][Header(Custom Params)][Header((Base Color))][Space(10)][Toggle(_ONLYALBEDOMAP_ON)] _OnlyAlbedoMap("Only Albedo Map", Float) = 0
		_BaseColor("BaseColor", Color) = (1,1,1,0)
		[Header((Tint Color))][Space(10)][Toggle(_USETINT_ON)] _UseTint("Use Tint", Float) = 0
		[NoScaleOffset][SingleLineTexture]_TintMask("Tint Mask", 2D) = "white" {}
		_TintColor("Tint Color", Color) = (1,1,1,0)
		_TintIntensity("Tint Intensity", Range( 0 , 1)) = 0
		[Header((Color Adjustment))][Space(10)][Toggle(_USEADJUSTMENT_ON)] _UseAdjustment("Use Adjustment", Float) = 0
		_Contrast("Contrast", Range( 0 , 2)) = 0
		_Saturate("Saturate", Range( -1 , 1)) = 1
		[Header((Bump))][Space(10)]_NormalIntensity("Normal Intensity", Range( 0 , 5)) = 1
		[Header((Reflection))][Space(10)][Toggle(_ONLYMRAMAP_ON)] _OnlyMRAMap("Only MRA Map", Float) = 0
		[Header((Metallic))][Space(10)]_MetallicWeight("Metallic Weight", Range( 0 , 1)) = 1
		_BaseMetallic("Base Metallic", Range( 0 , 1)) = 0
		[Toggle(_USEMETALLICMAPCONTRAST_ON)] _UseMetallicMapContrast("Use Metallic Map Contrast", Float) = 0
		_MetallicMapContrast("Metallic Map Contrast", Float) = 0
		[Header(Roughness)][Space(10)]_RoughnessWeight("Roughness Weight", Range( 0 , 1)) = 1
		_BaseRoughness("Base Roughness", Range( 0 , 1)) = 0.5
		[Toggle(_USEROUGHNESSMAPCONTRAST_ON)] _UseRoughnessMapContrast("Use Roughness Map Contrast", Float) = 0
		_RoughnessMapContrast("Roughness Map Contrast", Float) = 0
		[Header((Ambient Occlussion))][Space(10)]_AOIntensity("AO Intensity", Range( 0 , 1)) = 1
		_AOMapAdd("AO Map Add", Range( 0 , 1)) = 0
		[Toggle(_USEAOMAPCONTRAST_ON)] _UseAOMapContrast("Use AO Map Contrast", Float) = 0
		_AOMapContrast("AO Map Contrast", Float) = 0
		[Header((Emission))][Space(10)][Toggle(_USEEMISSION_ON)] _UseEmission("Use Emission", Float) = 0
		[Toggle(_ONLYEMISSIONMAP_ON)] _OnlyEmissionMap("Only Emission Map", Float) = 0
		[HDR]_EmissionColor("Emission Color", Color) = (1,1,1,0)
		_EmissionIntensity("Emission Intensity", Range( 0 , 10)) = 1
		[Header(_________________________________________________________________________________________________)][Header(Add Details)][Header((Deatil UVs))][Space(10)][KeywordEnum(MainUVs,DetailUVs)] _DetailUVsMode("Detail UVs Mode", Float) = 1
		_DetailTillingandOffset("Detail Tilling and Offset", Vector) = (1,1,0,0)
		[Toggle(_USEDETAILROTATION_ON)] _UseDetailRotation("Use Detail Rotation", Float) = 0
		_DetailRotationX("Detail Rotation X", Float) = 0
		_DetailRotationY("Detail Rotation Y", Float) = 0
		_DetailRotationAngle("Detail Rotation Angle", Range( 0 , 1)) = 0
		[Header((Detail Mask))][NoScaleOffset][SingleLineTexture][Space(10)]_DetailMask("Detail Mask", 2D) = "white" {}
		[Toggle(_INVETDETAILMASK_ON)] _InvetDetailMask("Invet Detail Mask", Float) = 0
		_DetailIntensity("Detail Intensity", Range( 0 , 1)) = 0
		[Header((Detail Color))][Space(10)][Toggle(_USEDETAILCOLOR_ON)] _UseDetailColor("Use Detail Color", Float) = 0
		[Toggle(_ONLYDETAILALBEDOMAP_ON)] _OnlyDetailAlbedoMap("Only Detail Albedo Map", Float) = 0
		_DetailBaseColor("Detail Base Color", Color) = (1,1,1,0)
		[NoScaleOffset][SingleLineTexture]_DetailAlbedo("Detail Albedo", 2D) = "white" {}
		[Header((Detail Normal))][Space(10)][Toggle(_USEDETAILNORMAL_ON)] _UseDetailNormal("Use Detail Normal", Float) = 0
		[NoScaleOffset][Normal][SingleLineTexture]_DetailNormal("Detail Normal", 2D) = "bump" {}
		_DetailNormalIntensity("Detail Normal Intensity", Range( 0 , 5)) = 0.5
		[Header((Detail Metallic))][Space(10)][Toggle(_USEDETAILMETALLIC_ON)] _UseDetailMetallic("Use Detail Metallic", Float) = 0
		_DetailMetallicMapWeight("Detail Metallic Map Weight", Range( 0 , 1)) = 0
		_BaseDetailMetallic("Base Detail Metallic", Range( 0 , 1)) = 0
		[Toggle(_USEDETAILMETALLICMAPCONTRAST_ON)] _UseDetailMetallicMapContrast("Use Detail Metallic Map Contrast", Float) = 0
		_DetailMetallicMapContrast("Detail Metallic Map Contrast", Float) = 0
		[Header((Detail Roughness))][Space(10)][Toggle(_USEDETAILROUGHNESS_ON)] _UseDetailRoughness("Use Detail Roughness", Float) = 0
		_DetailRoughnessMapWeight("Detail Roughness Map Weight", Range( 0 , 1)) = 1
		_BaseDetailRoughness("Base Detail Roughness", Range( 0 , 1)) = 0.5
		[Toggle(_USEDETAILROUGHNESSMAPCONTRAST_ON)] _UseDetailRoughnessMapContrast("Use Detail Roughness Map Contrast", Float) = 0
		_DetailRoughnessMapContrast("Detail Roughness Map Contrast", Float) = 0
		[Header((Detail Ambient Occlussion))][Space(10)][Toggle(_USEDETAILAOMAPCONTRAST_ON)] _UseDetailAOMapContrast("Use Detail AO Map Contrast", Float) = 0
		_DetailAOMapContrast("Detail AO Map Contrast", Float) = 0
		_DetailAOIntensity("Detail AO Intensity", Range( 0 , 1)) = 1
		_DetailAOMapAdd("Detail AO Map Add", Range( 0 , 1)) = 0


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[HideInInspector][ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1.0
		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0

		[HideInInspector] _QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector] _QueueControl("_QueueControl", Float) = -1

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "UniversalMaterialType"="Lit" }

		Cull [_CullMode]
		ZWrite On
		ZTest LEqual
		Offset 0,0
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 5.0
		#pragma prefer_hlslcc gles
		#pragma only_renderers d3d11 // ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForwardOnly" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0,0
			ColorMask RGBA

			

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140008
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			#pragma multi_compile_fragment _ _SHADOWS_SOFT
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _LIGHT_LAYERS
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
			#pragma multi_compile _ _FORWARD_PLUS

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#pragma multi_compile_fragment _ _WRITE_RENDERING_LAYERS

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_FORWARD

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#pragma shader_feature_local _USEDETAILCOLOR_ON
			#pragma shader_feature_local _USEADJUSTMENT_ON
			#pragma shader_feature_local _USETINT_ON
			#pragma shader_feature_local _ONLYALBEDOMAP_ON
			#pragma shader_feature_local _USEUVSROTATION_ON
			#pragma shader_feature_local _ONLYDETAILALBEDOMAP_ON
			#pragma shader_feature_local _USEDETAILROTATION_ON
			#pragma shader_feature_local _INVETDETAILMASK_ON
			#pragma shader_feature_local _DETAILUVSMODE_MAINUVS _DETAILUVSMODE_DETAILUVS
			#pragma shader_feature_local _USEDETAILNORMAL_ON
			#pragma shader_feature_local _USEEMISSION_ON
			#pragma shader_feature_local _ONLYEMISSIONMAP_ON
			#pragma shader_feature_local _USEDETAILMETALLIC_ON
			#pragma shader_feature_local _ONLYMRAMAP_ON
			#pragma shader_feature_local _USEMETALLICMAPCONTRAST_ON
			#pragma shader_feature_local _USEDETAILMETALLICMAPCONTRAST_ON
			#pragma shader_feature_local _USEDETAILROUGHNESS_ON
			#pragma shader_feature_local _USEROUGHNESSMAPCONTRAST_ON
			#pragma shader_feature_local _USEDETAILROUGHNESSMAPCONTRAST_ON
			#pragma shader_feature_local _USEDETAILAOMAPCONTRAST_ON
			#pragma shader_feature_local _USEAOMAPCONTRAST_ON


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 clipPos : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float4 lightmapUVOrVertexSH : TEXCOORD1;
				half4 fogFactorAndVertexLight : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					float4 shadowCoord : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 _TillingandOffset;
			float4 _TintColor;
			float4 _EmissionColor;
			float4 _DetailTillingandOffset;
			float4 _DetailBaseColor;
			int _CullMode;
			float _MetallicWeight;
			float _BaseDetailMetallic;
			float _DetailMetallicMapContrast;
			float _DetailMetallicMapWeight;
			float _BaseRoughness;
			float _RoughnessMapContrast;
			float _BaseDetailRoughness;
			float _DetailRoughnessMapContrast;
			float _DetailRoughnessMapWeight;
			float _DetailAOMapAdd;
			float _DetailAOMapContrast;
			float _DetailAOIntensity;
			float _AOMapAdd;
			float _RoughnessWeight;
			float _MetallicMapContrast;
			float _DetailNormalIntensity;
			float _EmissionIntensity;
			float _ZWrite;
			int _ZTest;
			float _RotationCenterX;
			float _RotationCenterY;
			float _RotationAngle;
			float _TintIntensity;
			float _BaseMetallic;
			float _Contrast;
			float _DetailRotationX;
			float _DetailRotationY;
			float _DetailRotationAngle;
			float _DetailIntensity;
			float _NormalIntensity;
			float _AOMapContrast;
			float _Saturate;
			float _AOIntensity;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_Albedo);
			SAMPLER(sampler_Albedo);
			TEXTURE2D(_TintMask);
			SAMPLER(sampler_TintMask);
			TEXTURE2D(_DetailAlbedo);
			SAMPLER(sampler_DetailAlbedo);
			TEXTURE2D(_DetailMask);
			SAMPLER(sampler_DetailMask);
			TEXTURE2D(_Normal);
			SAMPLER(sampler_Normal);
			TEXTURE2D(_DetailNormal);
			SAMPLER(sampler_DetailNormal);
			TEXTURE2D(_Emission);
			SAMPLER(sampler_Emission);
			TEXTURE2D(_MRA);
			SAMPLER(sampler_MRA);


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord8.xy = v.texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord8.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				#endif

				#if !defined(LIGHTMAP_ON)
					OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord.xy;
					o.lightmapUVOrVertexSH.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );

				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( positionCS.z );
				#else
					half fogFactor = 0;
				#endif

				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				o.clipPosV = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.clipPos );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif

				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				float2 NormalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.clipPos);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif

				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float2 appendResult158 = (float2(_TillingandOffset.x , _TillingandOffset.y));
				float2 UVsTilling160 = appendResult158;
				float2 texCoord129 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult159 = (float2(_TillingandOffset.z , _TillingandOffset.w));
				float2 UVsOffset161 = appendResult159;
				float2 BaseUV14 = ( ( UVsTilling160 * texCoord129 ) + UVsOffset161 );
				float2 appendResult149 = (float2(_RotationCenterX , _RotationCenterY));
				float2 temp_output_33_0_g22 = appendResult149;
				float2 temp_output_41_0_g22 = ( -temp_output_33_0_g22 + BaseUV14 );
				float temp_output_11_0_g22 = _RotationAngle;
				float temp_output_37_0_g22 = cos( temp_output_11_0_g22 );
				float2 appendResult45_g22 = (float2(temp_output_37_0_g22 , -sin( temp_output_11_0_g22 )));
				float dotResult43_g22 = dot( temp_output_41_0_g22 , appendResult45_g22 );
				float2 appendResult38_g22 = (float2(-sin( temp_output_11_0_g22 ) , temp_output_37_0_g22));
				float dotResult44_g22 = dot( temp_output_41_0_g22 , appendResult38_g22 );
				float2 appendResult46_g22 = (float2(dotResult43_g22 , dotResult44_g22));
				#ifdef _USEUVSROTATION_ON
				float2 staticSwitch147 = ( temp_output_33_0_g22 + appendResult46_g22 );
				#else
				float2 staticSwitch147 = BaseUV14;
				#endif
				float2 RotationUVs154 = staticSwitch147;
				float3 temp_output_34_0 = (SAMPLE_TEXTURE2D( _Albedo, sampler_Albedo, RotationUVs154 )).rgb;
				#ifdef _ONLYALBEDOMAP_ON
				float3 staticSwitch19 = temp_output_34_0;
				#else
				float3 staticSwitch19 = ( (_BaseColor).rgb * temp_output_34_0 );
				#endif
				float4 tex2DNode205 = SAMPLE_TEXTURE2D( _TintMask, sampler_TintMask, RotationUVs154 );
				float lerpResult210 = lerp( 0.0 , tex2DNode205.r , ( tex2DNode205.r * _TintIntensity ));
				float TintMask212 = lerpResult210;
				float3 lerpResult207 = lerp( staticSwitch19 , (( float4( temp_output_34_0 , 0.0 ) * _TintColor )).rgb , TintMask212);
				#ifdef _USETINT_ON
				float3 staticSwitch23 = lerpResult207;
				#else
				float3 staticSwitch23 = staticSwitch19;
				#endif
				float3 lerpResult62 = lerp( float3( 0.5,0.5,0.5 ) , staticSwitch23 , _Contrast);
				#ifdef _USEADJUSTMENT_ON
				float3 staticSwitch77 = lerpResult62;
				#else
				float3 staticSwitch77 = staticSwitch23;
				#endif
				float3 desaturateInitialColor45 = staticSwitch77;
				float desaturateDot45 = dot( desaturateInitialColor45, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar45 = lerp( desaturateInitialColor45, desaturateDot45.xxx, -_Saturate );
				#ifdef _USEADJUSTMENT_ON
				float3 staticSwitch78 = desaturateVar45;
				#else
				float3 staticSwitch78 = staticSwitch77;
				#endif
				float3 PBRColor325 = staticSwitch78;
				float2 texCoord256 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult274 = (float2(_DetailTillingandOffset.x , _DetailTillingandOffset.y));
				float2 DetailUVsTilling276 = appendResult274;
				float2 appendResult275 = (float2(_DetailTillingandOffset.z , _DetailTillingandOffset.w));
				float2 DetailUVsOffset277 = appendResult275;
				float2 DetailUVsBase283 = ( ( texCoord256 * DetailUVsTilling276 ) + DetailUVsOffset277 );
				float2 appendResult284 = (float2(_DetailRotationX , _DetailRotationY));
				float2 temp_output_33_0_g31 = appendResult284;
				float2 temp_output_41_0_g31 = ( -temp_output_33_0_g31 + DetailUVsBase283 );
				float temp_output_11_0_g31 = _DetailRotationAngle;
				float temp_output_37_0_g31 = cos( temp_output_11_0_g31 );
				float2 appendResult45_g31 = (float2(temp_output_37_0_g31 , -sin( temp_output_11_0_g31 )));
				float dotResult43_g31 = dot( temp_output_41_0_g31 , appendResult45_g31 );
				float2 appendResult38_g31 = (float2(-sin( temp_output_11_0_g31 ) , temp_output_37_0_g31));
				float dotResult44_g31 = dot( temp_output_41_0_g31 , appendResult38_g31 );
				float2 appendResult46_g31 = (float2(dotResult43_g31 , dotResult44_g31));
				#ifdef _USEDETAILROTATION_ON
				float2 staticSwitch308 = ( temp_output_33_0_g31 + appendResult46_g31 );
				#else
				float2 staticSwitch308 = DetailUVsBase283;
				#endif
				float2 DetailRotationUVs289 = staticSwitch308;
				float3 temp_output_310_0 = (SAMPLE_TEXTURE2D( _DetailAlbedo, sampler_DetailAlbedo, DetailRotationUVs289 )).rgb;
				#ifdef _ONLYDETAILALBEDOMAP_ON
				float3 staticSwitch315 = temp_output_310_0;
				#else
				float3 staticSwitch315 = ( (_DetailBaseColor).rgb * temp_output_310_0 );
				#endif
				#if defined(_DETAILUVSMODE_MAINUVS)
				float2 staticSwitch394 = RotationUVs154;
				#elif defined(_DETAILUVSMODE_DETAILUVS)
				float2 staticSwitch394 = DetailRotationUVs289;
				#else
				float2 staticSwitch394 = DetailRotationUVs289;
				#endif
				float2 DetailUVs397 = staticSwitch394;
				float4 tex2DNode292 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, DetailUVs397 );
				float Mask412 = tex2DNode292.a;
				#ifdef _INVETDETAILMASK_ON
				float staticSwitch300 = ( 1.0 - Mask412 );
				#else
				float staticSwitch300 = Mask412;
				#endif
				float DetailGlobalIntensity362 = _DetailIntensity;
				float DetailMask296 = ( staticSwitch300 * max( 0.001 , DetailGlobalIntensity362 ) );
				float3 DetailColor318 = ( staticSwitch315 * DetailMask296 );
				float3 lerpResult390 = lerp( PBRColor325 , DetailColor318 , DetailMask296);
				#ifdef _USEDETAILCOLOR_ON
				float3 staticSwitch326 = lerpResult390;
				#else
				float3 staticSwitch326 = PBRColor325;
				#endif
				float3 COLOR31 = staticSwitch326;
				
				float3 unpack11 = UnpackNormalScale( SAMPLE_TEXTURE2D( _Normal, sampler_Normal, RotationUVs154 ), _NormalIntensity );
				unpack11.z = lerp( 1, unpack11.z, saturate(_NormalIntensity) );
				float3 BaseNormal260 = unpack11;
				float3 unpack255 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormal, sampler_DetailNormal, DetailRotationUVs289 ), _DetailNormalIntensity );
				unpack255.z = lerp( 1, unpack255.z, saturate(_DetailNormalIntensity) );
				float3 DetailNormal259 = unpack255;
				float3 lerpResult439 = lerp( BaseNormal260 , DetailNormal259 , DetailMask296);
				#ifdef _USEDETAILNORMAL_ON
				float3 staticSwitch294 = lerpResult439;
				#else
				float3 staticSwitch294 = BaseNormal260;
				#endif
				float3 NORMAL79 = staticSwitch294;
				
				float3 temp_cast_1 = (0.0).xxx;
				float3 temp_output_189_0 = ( (SAMPLE_TEXTURE2D( _Emission, sampler_Emission, RotationUVs154 )).rgb * _EmissionIntensity );
				#ifdef _ONLYEMISSIONMAP_ON
				float3 staticSwitch194 = temp_output_189_0;
				#else
				float3 staticSwitch194 = ( (_EmissionColor).rgb * temp_output_189_0 );
				#endif
				#ifdef _USEEMISSION_ON
				float3 staticSwitch192 = staticSwitch194;
				#else
				float3 staticSwitch192 = temp_cast_1;
				#endif
				float3 EMISSION198 = staticSwitch192;
				
				float4 tex2DNode12 = SAMPLE_TEXTURE2D( _MRA, sampler_MRA, RotationUVs154 );
				float MetallicMap179 = tex2DNode12.r;
				float temp_output_11_0_g32 = _MetallicMapContrast;
				float lerpResult36_g32 = lerp( ( 0.0 - temp_output_11_0_g32 ) , ( temp_output_11_0_g32 + 1.0 ) , MetallicMap179);
				#ifdef _USEMETALLICMAPCONTRAST_ON
				float staticSwitch222 = saturate( lerpResult36_g32 );
				#else
				float staticSwitch222 = MetallicMap179;
				#endif
				float lerpResult171 = lerp( _BaseMetallic , staticSwitch222 , _MetallicWeight);
				#ifdef _ONLYMRAMAP_ON
				float staticSwitch96 = MetallicMap179;
				#else
				float staticSwitch96 = lerpResult171;
				#endif
				float PBRMetallic350 = staticSwitch96;
				float DetailMetallicMap334 = tex2DNode292.r;
				float temp_output_11_0_g34 = _DetailMetallicMapContrast;
				float lerpResult36_g34 = lerp( ( 0.0 - temp_output_11_0_g34 ) , ( temp_output_11_0_g34 + 1.0 ) , DetailMetallicMap334);
				#ifdef _USEDETAILMETALLICMAPCONTRAST_ON
				float staticSwitch345 = saturate( lerpResult36_g34 );
				#else
				float staticSwitch345 = DetailMetallicMap334;
				#endif
				float lerpResult339 = lerp( _BaseDetailMetallic , staticSwitch345 , _DetailMetallicMapWeight);
				float DetailMetallic338 = lerpResult339;
				float lerpResult353 = lerp( PBRMetallic350 , DetailMetallic338 , DetailMask296);
				#ifdef _USEDETAILMETALLIC_ON
				float staticSwitch392 = lerpResult353;
				#else
				float staticSwitch392 = PBRMetallic350;
				#endif
				float METALLIC99 = staticSwitch392;
				
				float RoughnessMap181 = ( 1.0 - tex2DNode12.g );
				float temp_output_11_0_g18 = _RoughnessMapContrast;
				float lerpResult36_g18 = lerp( ( 0.0 - temp_output_11_0_g18 ) , ( temp_output_11_0_g18 + 1.0 ) , RoughnessMap181);
				#ifdef _USEROUGHNESSMAPCONTRAST_ON
				float staticSwitch218 = saturate( lerpResult36_g18 );
				#else
				float staticSwitch218 = RoughnessMap181;
				#endif
				float lerpResult174 = lerp( max( 0.001 , ( 1.0 - _BaseRoughness ) ) , staticSwitch218 , _RoughnessWeight);
				#ifdef _ONLYMRAMAP_ON
				float staticSwitch73 = RoughnessMap181;
				#else
				float staticSwitch73 = lerpResult174;
				#endif
				float PBRRoughness379 = staticSwitch73;
				float DetailRoughnessMap333 = ( 1.0 - tex2DNode292.g );
				float temp_output_11_0_g35 = _DetailRoughnessMapContrast;
				float lerpResult36_g35 = lerp( ( 0.0 - temp_output_11_0_g35 ) , ( temp_output_11_0_g35 + 1.0 ) , DetailRoughnessMap333);
				#ifdef _USEDETAILROUGHNESSMAPCONTRAST_ON
				float staticSwitch371 = saturate( lerpResult36_g35 );
				#else
				float staticSwitch371 = DetailRoughnessMap333;
				#endif
				float lerpResult373 = lerp( max( 0.001 , ( 1.0 - _BaseDetailRoughness ) ) , staticSwitch371 , _DetailRoughnessMapWeight);
				float DetailRoughness377 = lerpResult373;
				float lerpResult383 = lerp( PBRRoughness379 , DetailRoughness377 , DetailMask296);
				#ifdef _USEDETAILROUGHNESS_ON
				float staticSwitch393 = lerpResult383;
				#else
				float staticSwitch393 = PBRRoughness379;
				#endif
				float ROUGHNESS100 = staticSwitch393;
				
				float DetailAOMap406 = tex2DNode292.b;
				float temp_output_418_0 = ( DetailAOMap406 - _DetailAOMapAdd );
				float temp_output_11_0_g37 = _DetailAOMapContrast;
				float lerpResult36_g37 = lerp( ( 0.0 - temp_output_11_0_g37 ) , ( temp_output_11_0_g37 + 1.0 ) , temp_output_418_0);
				#ifdef _USEDETAILAOMAPCONTRAST_ON
				float staticSwitch415 = saturate( lerpResult36_g37 );
				#else
				float staticSwitch415 = temp_output_418_0;
				#endif
				float lerpResult425 = lerp( 1.0 , staticSwitch415 , _DetailAOIntensity);
				float DetailAO424 = ( lerpResult425 * DetailMask296 );
				float AOMap95 = tex2DNode12.b;
				float temp_output_433_0 = saturate( ( AOMap95 - _AOMapAdd ) );
				float temp_output_11_0_g38 = _AOMapContrast;
				float lerpResult36_g38 = lerp( ( 0.0 - temp_output_11_0_g38 ) , ( temp_output_11_0_g38 + 1.0 ) , temp_output_433_0);
				#ifdef _USEAOMAPCONTRAST_ON
				float staticSwitch230 = saturate( lerpResult36_g38 );
				#else
				float staticSwitch230 = temp_output_433_0;
				#endif
				float lerpResult104 = lerp( 1.0 , staticSwitch230 , _AOIntensity);
				#ifdef _ONLYMRAMAP_ON
				float staticSwitch177 = AOMap95;
				#else
				float staticSwitch177 = lerpResult104;
				#endif
				float PBRAO101 = staticSwitch177;
				float AO429 = saturate( min( DetailAO424 , PBRAO101 ) );
				

				float3 BaseColor = COLOR31;
				float3 Normal = NORMAL79;
				float3 Emission = EMISSION198;
				float3 Specular = 0.5;
				float Metallic = METALLIC99;
				float Smoothness = ROUGHNESS100;
				float Occlusion = AO429;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.clipPos.z;
				#endif

				#ifdef _CLEARCOAT
					float CoatMask = 0;
					float CoatSmoothness = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;

				#ifdef _NORMALMAP
						#if _NORMAL_DROPOFF_TS
							inputData.normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent, WorldBiTangent, WorldNormal));
						#elif _NORMAL_DROPOFF_OS
							inputData.normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							inputData.normalWS = Normal;
						#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					inputData.shadowCoord = ShadowCoords;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					inputData.shadowCoord = TransformWorldToShadowCoord(inputData.positionWS);
				#else
					inputData.shadowCoord = float4(0, 0, 0, 0);
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif
					inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(IN.lightmapUVOrVertexSH.xy, IN.dynamicLightmapUV.xy, SH, inputData.normalWS);
				#else
					inputData.bakedGI = SAMPLE_GI(IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS);
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				inputData.normalizedScreenSpaceUV = NormalizedScreenSpaceUV;
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
					#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = IN.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				SurfaceData surfaceData;
				surfaceData.albedo              = BaseColor;
				surfaceData.metallic            = saturate(Metallic);
				surfaceData.specular            = Specular;
				surfaceData.smoothness          = saturate(Smoothness),
				surfaceData.occlusion           = Occlusion,
				surfaceData.emission            = Emission,
				surfaceData.alpha               = saturate(Alpha);
				surfaceData.normalTS            = Normal;
				surfaceData.clearCoatMask       = 0;
				surfaceData.clearCoatSmoothness = 1;

				#ifdef _CLEARCOAT
					surfaceData.clearCoatMask       = saturate(CoatMask);
					surfaceData.clearCoatSmoothness = saturate(CoatSmoothness);
				#endif

				#ifdef _DBUFFER
					ApplyDecalToSurfaceData(IN.clipPos, surfaceData, inputData);
				#endif

				half4 color = UniversalFragmentPBR( inputData, surfaceData);

				#ifdef ASE_TRANSMISSION
				{
					float shadow = _TransmissionShadow;

					#define SUM_LIGHT_TRANSMISSION(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 transmission = max( 0, -dot( inputData.normalWS, Light.direction ) ) * atten * Transmission;\
						color.rgb += BaseColor * transmission;

					SUM_LIGHT_TRANSMISSION( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_FORWARD_PLUS
							for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								FORWARD_PLUS_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSMISSION( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSMISSION( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_TRANSLUCENCY
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					#define SUM_LIGHT_TRANSLUCENCY(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 lightDir = Light.direction + inputData.normalWS * normal;\
						half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );\
						half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;\
						color.rgb += BaseColor * translucency * strength;

					SUM_LIGHT_TRANSLUCENCY( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_FORWARD_PLUS
							for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								FORWARD_PLUS_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSLUCENCY( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSLUCENCY( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_REFRACTION
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( WorldNormal,0 ) ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4( EncodeMeshRenderingLayer( renderingLayers ), 0, 0, 0 );
				#endif

				return color;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			ColorMask 0

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140008
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#define SHADERPASS SHADERPASS_SHADOWCASTER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 clipPos : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 worldPos : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD2;
				#endif				
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 _TillingandOffset;
			float4 _TintColor;
			float4 _EmissionColor;
			float4 _DetailTillingandOffset;
			float4 _DetailBaseColor;
			int _CullMode;
			float _MetallicWeight;
			float _BaseDetailMetallic;
			float _DetailMetallicMapContrast;
			float _DetailMetallicMapWeight;
			float _BaseRoughness;
			float _RoughnessMapContrast;
			float _BaseDetailRoughness;
			float _DetailRoughnessMapContrast;
			float _DetailRoughnessMapWeight;
			float _DetailAOMapAdd;
			float _DetailAOMapContrast;
			float _DetailAOIntensity;
			float _AOMapAdd;
			float _RoughnessWeight;
			float _MetallicMapContrast;
			float _DetailNormalIntensity;
			float _EmissionIntensity;
			float _ZWrite;
			int _ZTest;
			float _RotationCenterX;
			float _RotationCenterY;
			float _RotationAngle;
			float _TintIntensity;
			float _BaseMetallic;
			float _Contrast;
			float _DetailRotationX;
			float _DetailRotationY;
			float _DetailRotationAngle;
			float _DetailIntensity;
			float _NormalIntensity;
			float _AOMapContrast;
			float _Saturate;
			float _AOIntensity;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			
			float3 _LightDirection;
			float3 _LightPosition;

			VertexOutput VertexFunction( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.worldPos = positionWS;
				#endif

				float3 normalWS = TransformObjectToWorldDir(v.ase_normal);

				#if _CASTING_PUNCTUAL_LIGHT_SHADOW
					float3 lightDirectionWS = normalize(_LightPosition - positionWS);
				#else
					float3 lightDirectionWS = _LightDirection;
				#endif

				float4 clipPos = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));

				#if UNITY_REVERSED_Z
					clipPos.z = min(clipPos.z, UNITY_NEAR_CLIP_VALUE);
				#else
					clipPos.z = max(clipPos.z, UNITY_NEAR_CLIP_VALUE);
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = clipPos;
				o.clipPosV = clipPos;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(	VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.worldPos;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				

				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.clipPos.z;
				#endif

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.clipPos );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140008
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
			
			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 clipPos : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD2;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 _TillingandOffset;
			float4 _TintColor;
			float4 _EmissionColor;
			float4 _DetailTillingandOffset;
			float4 _DetailBaseColor;
			int _CullMode;
			float _MetallicWeight;
			float _BaseDetailMetallic;
			float _DetailMetallicMapContrast;
			float _DetailMetallicMapWeight;
			float _BaseRoughness;
			float _RoughnessMapContrast;
			float _BaseDetailRoughness;
			float _DetailRoughnessMapContrast;
			float _DetailRoughnessMapWeight;
			float _DetailAOMapAdd;
			float _DetailAOMapContrast;
			float _DetailAOIntensity;
			float _AOMapAdd;
			float _RoughnessWeight;
			float _MetallicMapContrast;
			float _DetailNormalIntensity;
			float _EmissionIntensity;
			float _ZWrite;
			int _ZTest;
			float _RotationCenterX;
			float _RotationCenterY;
			float _RotationAngle;
			float _TintIntensity;
			float _BaseMetallic;
			float _Contrast;
			float _DetailRotationX;
			float _DetailRotationY;
			float _DetailRotationAngle;
			float _DetailIntensity;
			float _NormalIntensity;
			float _AOMapContrast;
			float _Saturate;
			float _AOIntensity;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;
				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				o.clipPosV = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(	VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				

				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.clipPos.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.clipPos );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormalsOnly" }

			ZWrite On
			Blend One Zero
			ZTest LEqual
			ZWrite On

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140008
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile_fragment _ _WRITE_RENDERING_LAYERS

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#pragma shader_feature_local _USEDETAILNORMAL_ON
			#pragma shader_feature_local _USEUVSROTATION_ON
			#pragma shader_feature_local _USEDETAILROTATION_ON
			#pragma shader_feature_local _INVETDETAILMASK_ON
			#pragma shader_feature_local _DETAILUVSMODE_MAINUVS _DETAILUVSMODE_DETAILUVS


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 clipPos : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float3 worldNormal : TEXCOORD1;
				float4 worldTangent : TEXCOORD2;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 worldPos : TEXCOORD3;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD4;
				#endif
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 _TillingandOffset;
			float4 _TintColor;
			float4 _EmissionColor;
			float4 _DetailTillingandOffset;
			float4 _DetailBaseColor;
			int _CullMode;
			float _MetallicWeight;
			float _BaseDetailMetallic;
			float _DetailMetallicMapContrast;
			float _DetailMetallicMapWeight;
			float _BaseRoughness;
			float _RoughnessMapContrast;
			float _BaseDetailRoughness;
			float _DetailRoughnessMapContrast;
			float _DetailRoughnessMapWeight;
			float _DetailAOMapAdd;
			float _DetailAOMapContrast;
			float _DetailAOIntensity;
			float _AOMapAdd;
			float _RoughnessWeight;
			float _MetallicMapContrast;
			float _DetailNormalIntensity;
			float _EmissionIntensity;
			float _ZWrite;
			int _ZTest;
			float _RotationCenterX;
			float _RotationCenterY;
			float _RotationAngle;
			float _TintIntensity;
			float _BaseMetallic;
			float _Contrast;
			float _DetailRotationX;
			float _DetailRotationY;
			float _DetailRotationAngle;
			float _DetailIntensity;
			float _NormalIntensity;
			float _AOMapContrast;
			float _Saturate;
			float _AOIntensity;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_Normal);
			SAMPLER(sampler_Normal);
			TEXTURE2D(_DetailNormal);
			SAMPLER(sampler_DetailNormal);
			TEXTURE2D(_DetailMask);
			SAMPLER(sampler_DetailMask);


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord5.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;
				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 normalWS = TransformObjectToWorldNormal( v.ase_normal );
				float4 tangentWS = float4(TransformObjectToWorldDir( v.ase_tangent.xyz), v.ase_tangent.w);
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.worldPos = positionWS;
				#endif

				o.worldNormal = normalWS;
				o.worldTangent = tangentWS;

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				o.clipPosV = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void frag(	VertexOutput IN
						, out half4 outNormalWS : SV_Target0
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						 )
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.worldPos;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float3 WorldNormal = IN.worldNormal;
				float4 WorldTangent = IN.worldTangent;

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 appendResult158 = (float2(_TillingandOffset.x , _TillingandOffset.y));
				float2 UVsTilling160 = appendResult158;
				float2 texCoord129 = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult159 = (float2(_TillingandOffset.z , _TillingandOffset.w));
				float2 UVsOffset161 = appendResult159;
				float2 BaseUV14 = ( ( UVsTilling160 * texCoord129 ) + UVsOffset161 );
				float2 appendResult149 = (float2(_RotationCenterX , _RotationCenterY));
				float2 temp_output_33_0_g22 = appendResult149;
				float2 temp_output_41_0_g22 = ( -temp_output_33_0_g22 + BaseUV14 );
				float temp_output_11_0_g22 = _RotationAngle;
				float temp_output_37_0_g22 = cos( temp_output_11_0_g22 );
				float2 appendResult45_g22 = (float2(temp_output_37_0_g22 , -sin( temp_output_11_0_g22 )));
				float dotResult43_g22 = dot( temp_output_41_0_g22 , appendResult45_g22 );
				float2 appendResult38_g22 = (float2(-sin( temp_output_11_0_g22 ) , temp_output_37_0_g22));
				float dotResult44_g22 = dot( temp_output_41_0_g22 , appendResult38_g22 );
				float2 appendResult46_g22 = (float2(dotResult43_g22 , dotResult44_g22));
				#ifdef _USEUVSROTATION_ON
				float2 staticSwitch147 = ( temp_output_33_0_g22 + appendResult46_g22 );
				#else
				float2 staticSwitch147 = BaseUV14;
				#endif
				float2 RotationUVs154 = staticSwitch147;
				float3 unpack11 = UnpackNormalScale( SAMPLE_TEXTURE2D( _Normal, sampler_Normal, RotationUVs154 ), _NormalIntensity );
				unpack11.z = lerp( 1, unpack11.z, saturate(_NormalIntensity) );
				float3 BaseNormal260 = unpack11;
				float2 texCoord256 = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult274 = (float2(_DetailTillingandOffset.x , _DetailTillingandOffset.y));
				float2 DetailUVsTilling276 = appendResult274;
				float2 appendResult275 = (float2(_DetailTillingandOffset.z , _DetailTillingandOffset.w));
				float2 DetailUVsOffset277 = appendResult275;
				float2 DetailUVsBase283 = ( ( texCoord256 * DetailUVsTilling276 ) + DetailUVsOffset277 );
				float2 appendResult284 = (float2(_DetailRotationX , _DetailRotationY));
				float2 temp_output_33_0_g31 = appendResult284;
				float2 temp_output_41_0_g31 = ( -temp_output_33_0_g31 + DetailUVsBase283 );
				float temp_output_11_0_g31 = _DetailRotationAngle;
				float temp_output_37_0_g31 = cos( temp_output_11_0_g31 );
				float2 appendResult45_g31 = (float2(temp_output_37_0_g31 , -sin( temp_output_11_0_g31 )));
				float dotResult43_g31 = dot( temp_output_41_0_g31 , appendResult45_g31 );
				float2 appendResult38_g31 = (float2(-sin( temp_output_11_0_g31 ) , temp_output_37_0_g31));
				float dotResult44_g31 = dot( temp_output_41_0_g31 , appendResult38_g31 );
				float2 appendResult46_g31 = (float2(dotResult43_g31 , dotResult44_g31));
				#ifdef _USEDETAILROTATION_ON
				float2 staticSwitch308 = ( temp_output_33_0_g31 + appendResult46_g31 );
				#else
				float2 staticSwitch308 = DetailUVsBase283;
				#endif
				float2 DetailRotationUVs289 = staticSwitch308;
				float3 unpack255 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormal, sampler_DetailNormal, DetailRotationUVs289 ), _DetailNormalIntensity );
				unpack255.z = lerp( 1, unpack255.z, saturate(_DetailNormalIntensity) );
				float3 DetailNormal259 = unpack255;
				#if defined(_DETAILUVSMODE_MAINUVS)
				float2 staticSwitch394 = RotationUVs154;
				#elif defined(_DETAILUVSMODE_DETAILUVS)
				float2 staticSwitch394 = DetailRotationUVs289;
				#else
				float2 staticSwitch394 = DetailRotationUVs289;
				#endif
				float2 DetailUVs397 = staticSwitch394;
				float4 tex2DNode292 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, DetailUVs397 );
				float Mask412 = tex2DNode292.a;
				#ifdef _INVETDETAILMASK_ON
				float staticSwitch300 = ( 1.0 - Mask412 );
				#else
				float staticSwitch300 = Mask412;
				#endif
				float DetailGlobalIntensity362 = _DetailIntensity;
				float DetailMask296 = ( staticSwitch300 * max( 0.001 , DetailGlobalIntensity362 ) );
				float3 lerpResult439 = lerp( BaseNormal260 , DetailNormal259 , DetailMask296);
				#ifdef _USEDETAILNORMAL_ON
				float3 staticSwitch294 = lerpResult439;
				#else
				float3 staticSwitch294 = BaseNormal260;
				#endif
				float3 NORMAL79 = staticSwitch294;
				

				float3 Normal = NORMAL79;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.clipPos.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.clipPos );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				#if defined(_GBUFFER_NORMALS_OCT)
					float2 octNormalWS = PackNormalOctQuadEncode(WorldNormal);
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);
					outNormalWS = half4(packedNormalWS, 0.0);
				#else
					#if defined(_NORMALMAP)
						#if _NORMAL_DROPOFF_TS
							float crossSign = (WorldTangent.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
							float3 bitangent = crossSign * cross(WorldNormal.xyz, WorldTangent.xyz);
							float3 normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent.xyz, bitangent, WorldNormal.xyz));
						#elif _NORMAL_DROPOFF_OS
							float3 normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							float3 normalWS = Normal;
						#endif
					#else
						float3 normalWS = WorldNormal;
					#endif
					outNormalWS = half4(NormalizeNormalPerPixel(normalWS), 0.0);
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4( EncodeMeshRenderingLayer( renderingLayers ), 0, 0, 0 );
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="UniversalGBuffer" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0,0
			ColorMask RGBA
			

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140008
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			#pragma multi_compile_fragment _ _SHADOWS_SOFT
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
			#pragma multi_compile_fragment _ _WRITE_RENDERING_LAYERS

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_GBUFFER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif
			
			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#pragma shader_feature_local _USEDETAILCOLOR_ON
			#pragma shader_feature_local _USEADJUSTMENT_ON
			#pragma shader_feature_local _USETINT_ON
			#pragma shader_feature_local _ONLYALBEDOMAP_ON
			#pragma shader_feature_local _USEUVSROTATION_ON
			#pragma shader_feature_local _ONLYDETAILALBEDOMAP_ON
			#pragma shader_feature_local _USEDETAILROTATION_ON
			#pragma shader_feature_local _INVETDETAILMASK_ON
			#pragma shader_feature_local _DETAILUVSMODE_MAINUVS _DETAILUVSMODE_DETAILUVS
			#pragma shader_feature_local _USEDETAILNORMAL_ON
			#pragma shader_feature_local _USEEMISSION_ON
			#pragma shader_feature_local _ONLYEMISSIONMAP_ON
			#pragma shader_feature_local _USEDETAILMETALLIC_ON
			#pragma shader_feature_local _ONLYMRAMAP_ON
			#pragma shader_feature_local _USEMETALLICMAPCONTRAST_ON
			#pragma shader_feature_local _USEDETAILMETALLICMAPCONTRAST_ON
			#pragma shader_feature_local _USEDETAILROUGHNESS_ON
			#pragma shader_feature_local _USEROUGHNESSMAPCONTRAST_ON
			#pragma shader_feature_local _USEDETAILROUGHNESSMAPCONTRAST_ON
			#pragma shader_feature_local _USEDETAILAOMAPCONTRAST_ON
			#pragma shader_feature_local _USEAOMAPCONTRAST_ON


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 clipPos : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float4 lightmapUVOrVertexSH : TEXCOORD1;
				half4 fogFactorAndVertexLight : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
				float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 _TillingandOffset;
			float4 _TintColor;
			float4 _EmissionColor;
			float4 _DetailTillingandOffset;
			float4 _DetailBaseColor;
			int _CullMode;
			float _MetallicWeight;
			float _BaseDetailMetallic;
			float _DetailMetallicMapContrast;
			float _DetailMetallicMapWeight;
			float _BaseRoughness;
			float _RoughnessMapContrast;
			float _BaseDetailRoughness;
			float _DetailRoughnessMapContrast;
			float _DetailRoughnessMapWeight;
			float _DetailAOMapAdd;
			float _DetailAOMapContrast;
			float _DetailAOIntensity;
			float _AOMapAdd;
			float _RoughnessWeight;
			float _MetallicMapContrast;
			float _DetailNormalIntensity;
			float _EmissionIntensity;
			float _ZWrite;
			int _ZTest;
			float _RotationCenterX;
			float _RotationCenterY;
			float _RotationAngle;
			float _TintIntensity;
			float _BaseMetallic;
			float _Contrast;
			float _DetailRotationX;
			float _DetailRotationY;
			float _DetailRotationAngle;
			float _DetailIntensity;
			float _NormalIntensity;
			float _AOMapContrast;
			float _Saturate;
			float _AOIntensity;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_Albedo);
			SAMPLER(sampler_Albedo);
			TEXTURE2D(_TintMask);
			SAMPLER(sampler_TintMask);
			TEXTURE2D(_DetailAlbedo);
			SAMPLER(sampler_DetailAlbedo);
			TEXTURE2D(_DetailMask);
			SAMPLER(sampler_DetailMask);
			TEXTURE2D(_Normal);
			SAMPLER(sampler_Normal);
			TEXTURE2D(_DetailNormal);
			SAMPLER(sampler_DetailNormal);
			TEXTURE2D(_Emission);
			SAMPLER(sampler_Emission);
			TEXTURE2D(_MRA);
			SAMPLER(sampler_MRA);


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord8.xy = v.texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord8.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy);
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if !defined(LIGHTMAP_ON)
					OUTPUT_SH(normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz);
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord.xy;
					o.lightmapUVOrVertexSH.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );

				o.fogFactorAndVertexLight = half4(0, vertexLight);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				o.clipPosV = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			FragmentOutput frag ( VertexOutput IN
								#ifdef ASE_DEPTH_WRITE_ON
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								 )
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.clipPos );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif

				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				float2 NormalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.clipPos);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#else
					ShadowCoords = float4(0, 0, 0, 0);
				#endif

				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float2 appendResult158 = (float2(_TillingandOffset.x , _TillingandOffset.y));
				float2 UVsTilling160 = appendResult158;
				float2 texCoord129 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult159 = (float2(_TillingandOffset.z , _TillingandOffset.w));
				float2 UVsOffset161 = appendResult159;
				float2 BaseUV14 = ( ( UVsTilling160 * texCoord129 ) + UVsOffset161 );
				float2 appendResult149 = (float2(_RotationCenterX , _RotationCenterY));
				float2 temp_output_33_0_g22 = appendResult149;
				float2 temp_output_41_0_g22 = ( -temp_output_33_0_g22 + BaseUV14 );
				float temp_output_11_0_g22 = _RotationAngle;
				float temp_output_37_0_g22 = cos( temp_output_11_0_g22 );
				float2 appendResult45_g22 = (float2(temp_output_37_0_g22 , -sin( temp_output_11_0_g22 )));
				float dotResult43_g22 = dot( temp_output_41_0_g22 , appendResult45_g22 );
				float2 appendResult38_g22 = (float2(-sin( temp_output_11_0_g22 ) , temp_output_37_0_g22));
				float dotResult44_g22 = dot( temp_output_41_0_g22 , appendResult38_g22 );
				float2 appendResult46_g22 = (float2(dotResult43_g22 , dotResult44_g22));
				#ifdef _USEUVSROTATION_ON
				float2 staticSwitch147 = ( temp_output_33_0_g22 + appendResult46_g22 );
				#else
				float2 staticSwitch147 = BaseUV14;
				#endif
				float2 RotationUVs154 = staticSwitch147;
				float3 temp_output_34_0 = (SAMPLE_TEXTURE2D( _Albedo, sampler_Albedo, RotationUVs154 )).rgb;
				#ifdef _ONLYALBEDOMAP_ON
				float3 staticSwitch19 = temp_output_34_0;
				#else
				float3 staticSwitch19 = ( (_BaseColor).rgb * temp_output_34_0 );
				#endif
				float4 tex2DNode205 = SAMPLE_TEXTURE2D( _TintMask, sampler_TintMask, RotationUVs154 );
				float lerpResult210 = lerp( 0.0 , tex2DNode205.r , ( tex2DNode205.r * _TintIntensity ));
				float TintMask212 = lerpResult210;
				float3 lerpResult207 = lerp( staticSwitch19 , (( float4( temp_output_34_0 , 0.0 ) * _TintColor )).rgb , TintMask212);
				#ifdef _USETINT_ON
				float3 staticSwitch23 = lerpResult207;
				#else
				float3 staticSwitch23 = staticSwitch19;
				#endif
				float3 lerpResult62 = lerp( float3( 0.5,0.5,0.5 ) , staticSwitch23 , _Contrast);
				#ifdef _USEADJUSTMENT_ON
				float3 staticSwitch77 = lerpResult62;
				#else
				float3 staticSwitch77 = staticSwitch23;
				#endif
				float3 desaturateInitialColor45 = staticSwitch77;
				float desaturateDot45 = dot( desaturateInitialColor45, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar45 = lerp( desaturateInitialColor45, desaturateDot45.xxx, -_Saturate );
				#ifdef _USEADJUSTMENT_ON
				float3 staticSwitch78 = desaturateVar45;
				#else
				float3 staticSwitch78 = staticSwitch77;
				#endif
				float3 PBRColor325 = staticSwitch78;
				float2 texCoord256 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult274 = (float2(_DetailTillingandOffset.x , _DetailTillingandOffset.y));
				float2 DetailUVsTilling276 = appendResult274;
				float2 appendResult275 = (float2(_DetailTillingandOffset.z , _DetailTillingandOffset.w));
				float2 DetailUVsOffset277 = appendResult275;
				float2 DetailUVsBase283 = ( ( texCoord256 * DetailUVsTilling276 ) + DetailUVsOffset277 );
				float2 appendResult284 = (float2(_DetailRotationX , _DetailRotationY));
				float2 temp_output_33_0_g31 = appendResult284;
				float2 temp_output_41_0_g31 = ( -temp_output_33_0_g31 + DetailUVsBase283 );
				float temp_output_11_0_g31 = _DetailRotationAngle;
				float temp_output_37_0_g31 = cos( temp_output_11_0_g31 );
				float2 appendResult45_g31 = (float2(temp_output_37_0_g31 , -sin( temp_output_11_0_g31 )));
				float dotResult43_g31 = dot( temp_output_41_0_g31 , appendResult45_g31 );
				float2 appendResult38_g31 = (float2(-sin( temp_output_11_0_g31 ) , temp_output_37_0_g31));
				float dotResult44_g31 = dot( temp_output_41_0_g31 , appendResult38_g31 );
				float2 appendResult46_g31 = (float2(dotResult43_g31 , dotResult44_g31));
				#ifdef _USEDETAILROTATION_ON
				float2 staticSwitch308 = ( temp_output_33_0_g31 + appendResult46_g31 );
				#else
				float2 staticSwitch308 = DetailUVsBase283;
				#endif
				float2 DetailRotationUVs289 = staticSwitch308;
				float3 temp_output_310_0 = (SAMPLE_TEXTURE2D( _DetailAlbedo, sampler_DetailAlbedo, DetailRotationUVs289 )).rgb;
				#ifdef _ONLYDETAILALBEDOMAP_ON
				float3 staticSwitch315 = temp_output_310_0;
				#else
				float3 staticSwitch315 = ( (_DetailBaseColor).rgb * temp_output_310_0 );
				#endif
				#if defined(_DETAILUVSMODE_MAINUVS)
				float2 staticSwitch394 = RotationUVs154;
				#elif defined(_DETAILUVSMODE_DETAILUVS)
				float2 staticSwitch394 = DetailRotationUVs289;
				#else
				float2 staticSwitch394 = DetailRotationUVs289;
				#endif
				float2 DetailUVs397 = staticSwitch394;
				float4 tex2DNode292 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, DetailUVs397 );
				float Mask412 = tex2DNode292.a;
				#ifdef _INVETDETAILMASK_ON
				float staticSwitch300 = ( 1.0 - Mask412 );
				#else
				float staticSwitch300 = Mask412;
				#endif
				float DetailGlobalIntensity362 = _DetailIntensity;
				float DetailMask296 = ( staticSwitch300 * max( 0.001 , DetailGlobalIntensity362 ) );
				float3 DetailColor318 = ( staticSwitch315 * DetailMask296 );
				float3 lerpResult390 = lerp( PBRColor325 , DetailColor318 , DetailMask296);
				#ifdef _USEDETAILCOLOR_ON
				float3 staticSwitch326 = lerpResult390;
				#else
				float3 staticSwitch326 = PBRColor325;
				#endif
				float3 COLOR31 = staticSwitch326;
				
				float3 unpack11 = UnpackNormalScale( SAMPLE_TEXTURE2D( _Normal, sampler_Normal, RotationUVs154 ), _NormalIntensity );
				unpack11.z = lerp( 1, unpack11.z, saturate(_NormalIntensity) );
				float3 BaseNormal260 = unpack11;
				float3 unpack255 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormal, sampler_DetailNormal, DetailRotationUVs289 ), _DetailNormalIntensity );
				unpack255.z = lerp( 1, unpack255.z, saturate(_DetailNormalIntensity) );
				float3 DetailNormal259 = unpack255;
				float3 lerpResult439 = lerp( BaseNormal260 , DetailNormal259 , DetailMask296);
				#ifdef _USEDETAILNORMAL_ON
				float3 staticSwitch294 = lerpResult439;
				#else
				float3 staticSwitch294 = BaseNormal260;
				#endif
				float3 NORMAL79 = staticSwitch294;
				
				float3 temp_cast_1 = (0.0).xxx;
				float3 temp_output_189_0 = ( (SAMPLE_TEXTURE2D( _Emission, sampler_Emission, RotationUVs154 )).rgb * _EmissionIntensity );
				#ifdef _ONLYEMISSIONMAP_ON
				float3 staticSwitch194 = temp_output_189_0;
				#else
				float3 staticSwitch194 = ( (_EmissionColor).rgb * temp_output_189_0 );
				#endif
				#ifdef _USEEMISSION_ON
				float3 staticSwitch192 = staticSwitch194;
				#else
				float3 staticSwitch192 = temp_cast_1;
				#endif
				float3 EMISSION198 = staticSwitch192;
				
				float4 tex2DNode12 = SAMPLE_TEXTURE2D( _MRA, sampler_MRA, RotationUVs154 );
				float MetallicMap179 = tex2DNode12.r;
				float temp_output_11_0_g32 = _MetallicMapContrast;
				float lerpResult36_g32 = lerp( ( 0.0 - temp_output_11_0_g32 ) , ( temp_output_11_0_g32 + 1.0 ) , MetallicMap179);
				#ifdef _USEMETALLICMAPCONTRAST_ON
				float staticSwitch222 = saturate( lerpResult36_g32 );
				#else
				float staticSwitch222 = MetallicMap179;
				#endif
				float lerpResult171 = lerp( _BaseMetallic , staticSwitch222 , _MetallicWeight);
				#ifdef _ONLYMRAMAP_ON
				float staticSwitch96 = MetallicMap179;
				#else
				float staticSwitch96 = lerpResult171;
				#endif
				float PBRMetallic350 = staticSwitch96;
				float DetailMetallicMap334 = tex2DNode292.r;
				float temp_output_11_0_g34 = _DetailMetallicMapContrast;
				float lerpResult36_g34 = lerp( ( 0.0 - temp_output_11_0_g34 ) , ( temp_output_11_0_g34 + 1.0 ) , DetailMetallicMap334);
				#ifdef _USEDETAILMETALLICMAPCONTRAST_ON
				float staticSwitch345 = saturate( lerpResult36_g34 );
				#else
				float staticSwitch345 = DetailMetallicMap334;
				#endif
				float lerpResult339 = lerp( _BaseDetailMetallic , staticSwitch345 , _DetailMetallicMapWeight);
				float DetailMetallic338 = lerpResult339;
				float lerpResult353 = lerp( PBRMetallic350 , DetailMetallic338 , DetailMask296);
				#ifdef _USEDETAILMETALLIC_ON
				float staticSwitch392 = lerpResult353;
				#else
				float staticSwitch392 = PBRMetallic350;
				#endif
				float METALLIC99 = staticSwitch392;
				
				float RoughnessMap181 = ( 1.0 - tex2DNode12.g );
				float temp_output_11_0_g18 = _RoughnessMapContrast;
				float lerpResult36_g18 = lerp( ( 0.0 - temp_output_11_0_g18 ) , ( temp_output_11_0_g18 + 1.0 ) , RoughnessMap181);
				#ifdef _USEROUGHNESSMAPCONTRAST_ON
				float staticSwitch218 = saturate( lerpResult36_g18 );
				#else
				float staticSwitch218 = RoughnessMap181;
				#endif
				float lerpResult174 = lerp( max( 0.001 , ( 1.0 - _BaseRoughness ) ) , staticSwitch218 , _RoughnessWeight);
				#ifdef _ONLYMRAMAP_ON
				float staticSwitch73 = RoughnessMap181;
				#else
				float staticSwitch73 = lerpResult174;
				#endif
				float PBRRoughness379 = staticSwitch73;
				float DetailRoughnessMap333 = ( 1.0 - tex2DNode292.g );
				float temp_output_11_0_g35 = _DetailRoughnessMapContrast;
				float lerpResult36_g35 = lerp( ( 0.0 - temp_output_11_0_g35 ) , ( temp_output_11_0_g35 + 1.0 ) , DetailRoughnessMap333);
				#ifdef _USEDETAILROUGHNESSMAPCONTRAST_ON
				float staticSwitch371 = saturate( lerpResult36_g35 );
				#else
				float staticSwitch371 = DetailRoughnessMap333;
				#endif
				float lerpResult373 = lerp( max( 0.001 , ( 1.0 - _BaseDetailRoughness ) ) , staticSwitch371 , _DetailRoughnessMapWeight);
				float DetailRoughness377 = lerpResult373;
				float lerpResult383 = lerp( PBRRoughness379 , DetailRoughness377 , DetailMask296);
				#ifdef _USEDETAILROUGHNESS_ON
				float staticSwitch393 = lerpResult383;
				#else
				float staticSwitch393 = PBRRoughness379;
				#endif
				float ROUGHNESS100 = staticSwitch393;
				
				float DetailAOMap406 = tex2DNode292.b;
				float temp_output_418_0 = ( DetailAOMap406 - _DetailAOMapAdd );
				float temp_output_11_0_g37 = _DetailAOMapContrast;
				float lerpResult36_g37 = lerp( ( 0.0 - temp_output_11_0_g37 ) , ( temp_output_11_0_g37 + 1.0 ) , temp_output_418_0);
				#ifdef _USEDETAILAOMAPCONTRAST_ON
				float staticSwitch415 = saturate( lerpResult36_g37 );
				#else
				float staticSwitch415 = temp_output_418_0;
				#endif
				float lerpResult425 = lerp( 1.0 , staticSwitch415 , _DetailAOIntensity);
				float DetailAO424 = ( lerpResult425 * DetailMask296 );
				float AOMap95 = tex2DNode12.b;
				float temp_output_433_0 = saturate( ( AOMap95 - _AOMapAdd ) );
				float temp_output_11_0_g38 = _AOMapContrast;
				float lerpResult36_g38 = lerp( ( 0.0 - temp_output_11_0_g38 ) , ( temp_output_11_0_g38 + 1.0 ) , temp_output_433_0);
				#ifdef _USEAOMAPCONTRAST_ON
				float staticSwitch230 = saturate( lerpResult36_g38 );
				#else
				float staticSwitch230 = temp_output_433_0;
				#endif
				float lerpResult104 = lerp( 1.0 , staticSwitch230 , _AOIntensity);
				#ifdef _ONLYMRAMAP_ON
				float staticSwitch177 = AOMap95;
				#else
				float staticSwitch177 = lerpResult104;
				#endif
				float PBRAO101 = staticSwitch177;
				float AO429 = saturate( min( DetailAO424 , PBRAO101 ) );
				

				float3 BaseColor = COLOR31;
				float3 Normal = NORMAL79;
				float3 Emission = EMISSION198;
				float3 Specular = 0.5;
				float Metallic = METALLIC99;
				float Smoothness = ROUGHNESS100;
				float Occlusion = AO429;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.clipPos.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.positionCS = IN.clipPos;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
						inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
						inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
						inputData.normalWS = Normal;
					#endif
				#else
					inputData.normalWS = WorldNormal;
				#endif

				inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				inputData.viewDirectionWS = SafeNormalize( WorldViewDirection );

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#else
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, IN.dynamicLightmapUV.xy, SH, inputData.normalWS);
					#else
						inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
					#endif
				#endif

				inputData.normalizedScreenSpaceUV = NormalizedScreenSpaceUV;
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
						#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = IN.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				#ifdef _DBUFFER
					ApplyDecal(IN.clipPos,
						BaseColor,
						Specular,
						inputData.normalWS,
						Metallic,
						Occlusion,
						Smoothness);
				#endif

				BRDFData brdfData;
				InitializeBRDFData
				(BaseColor, Metallic, Specular, Smoothness, Alpha, brdfData);

				Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
				half4 color;
				MixRealtimeAndBakedGI(mainLight, inputData.normalWS, inputData.bakedGI, inputData.shadowMask);
				color.rgb = GlobalIllumination(brdfData, inputData.bakedGI, Occlusion, inputData.positionWS, inputData.normalWS, inputData.viewDirectionWS);
				color.a = Alpha;

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return BRDFDataToGbuffer(brdfData, inputData, Smoothness, Emission + color.rgb, Occlusion);
			}

			ENDHLSL
		}

	
	}
	
	CustomEditor "ASEMaterialInspector"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback Off
}
/*ASEBEGIN
Version=19201
Node;AmplifyShaderEditor.CommentaryNode;440;-2693.773,1318;Inherit;False;1003.457;323;NormalBlend;7;79;294;436;439;435;262;261;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;431;-1997.36,2318.185;Inherit;False;735.4386;211.2661;AOBlend;5;429;432;428;427;426;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;430;-3739.189,2317.439;Inherit;False;1727.272;321.0901;DetailAO;11;444;415;424;421;425;416;420;417;419;418;445;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;385;-2294.211,1985.297;Inherit;False;1022.941;318.2998;RoughnessBlend;6;393;383;100;382;381;443;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;380;-3737.724,1985.696;Inherit;False;1432.312;319.0029;DetailRoughness;10;377;387;388;376;371;369;372;370;375;373;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;361;-2314.538,1658.322;Inherit;False;934.792;298.0002;MetallicBlend;6;442;392;353;351;99;352;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;360;-3736.169,1657.953;Inherit;False;1410.267;312.6482;DetailMetallic;8;338;341;344;339;342;345;346;391;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;329;-1976.351,889.194;Inherit;False;1031.504;328.5864;ColorBlend;6;438;326;324;390;31;320;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;319;-3735.242,889.361;Inherit;False;1744.257;413.6816;DetailColor;10;309;315;318;322;323;307;316;314;313;310;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;305;-3735.723,1315.385;Inherit;False;1031.631;326.7387;DetailNormal;4;403;290;259;255;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;301;-3733.223,487.8535;Inherit;False;2026.815;379.5367;DetailMask;16;328;296;300;365;368;362;413;414;297;412;406;334;333;331;398;292;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;291;-3731.467,142.9652;Inherit;False;3446.531;325.8451;Detail UVs;22;289;395;397;394;308;273;287;277;276;275;274;288;279;284;286;285;283;281;282;257;280;256;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;235;-2071.328,-678.2744;Inherit;False;1875.082;334.5836;AO;12;101;177;104;185;106;230;232;250;433;234;233;184;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;228;-3729.574,-678.0176;Inherit;False;1643.967;351.845;Roughness;11;73;182;174;183;221;175;218;217;219;236;379;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;227;-2734.925,-1027.444;Inherit;False;1624.925;337.8698;Metallic;10;97;171;96;180;225;172;226;222;251;350;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;216;-3730.396,-1025.646;Inherit;False;978.5027;334.3746;MRA Input;6;12;179;181;95;71;40;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;214;-3730.244,-1826.037;Inherit;False;4326.244;515.7977;Color;27;34;75;76;62;54;45;19;23;78;74;48;46;77;10;25;67;36;207;156;213;20;209;210;208;205;212;325;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;204;1852.981,-1740.705;Inherit;False;468.0003;165;Rendering Settings;3;203;202;201;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;200;-3730.627,-315.6463;Inherit;False;1985.305;446.4434;Emission;12;188;191;196;195;189;190;187;197;194;193;192;198;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;168;-3729.738,-2195.175;Inherit;False;2641.953;349.5181;UVs;19;253;154;147;132;150;149;151;152;14;144;162;164;133;129;157;160;161;159;158;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;92;-3730.346,-1299.2;Inherit;False;897.1676;263.3019;Normal;4;11;37;38;260;;0,0,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-3594.091,-1226.58;Inherit;False;154;RotationUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;158;-3485.738,-2093.806;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;159;-3485.738,-2003.806;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;161;-3339.738,-2008.806;Inherit;False;UVsOffset;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;160;-3340.738,-2098.806;Inherit;False;UVsTilling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;188;-3680.628,-76.34634;Inherit;False;154;RotationUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;191;-3169.63,-99.34627;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;196;-2994.206,-265.6463;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;195;-3217.207,-265.6463;Inherit;False;Property;_EmissionColor;Emission Color;37;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;189;-2862.629,-93.34633;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;190;-3169.63,-25.34644;Inherit;False;Property;_EmissionIntensity;Emission Intensity;38;0;Create;True;0;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;197;-2672.625,-260.1793;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;193;-2382.962,-195.9653;Inherit;False;Constant;_noemiss;no emiss;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;198;-1973.326,-196.1733;Inherit;False;EMISSION;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;187;-3482.779,-99.20332;Inherit;True;Property;_Emission;Emission;6;3;[HDR];[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;157;-3706.738,-2103.806;Inherit;False;Property;_TillingandOffset;Tilling and Offset;7;1;[Header];Create;True;1;(UVs);0;0;False;1;Space(10);False;0,0,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;34;-2125.31,-1634.941;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-1906.772,-1771.037;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;62;-843.0229,-1594.819;Inherit;False;3;0;FLOAT3;0.5,0.5,0.5;False;1;FLOAT3;0.5,0.5,0.5;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;54;-344.908,-1552.249;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;45;-123.0216,-1575.25;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;23;-1163.469,-1658.338;Inherit;False;Property;_UseTint;Use Tint;14;0;Create;True;0;0;0;False;2;Header((Tint Color));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;78;95.57397,-1657.555;Inherit;False;Property;_UseAdjustment1;Use Adjustment;18;0;Create;True;0;0;0;False;2;Header((Tint Color));Space(5);False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;77;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;77;-589.1895,-1658.833;Inherit;False;Property;_UseAdjustment;Use Adjustment;18;0;Create;True;0;0;0;False;2;Header((Color Adjustment));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;10;-2440.127,-1634.919;Inherit;True;Property;_Albedo;Albedo;3;3;[Header];[NoScaleOffset];[SingleLineTexture];Create;True;3;_________________________________________________________________________________________________;Texture Inputs;(Base Map);0;0;False;1;Space(10);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;156;-2627.439,-1612.219;Inherit;False;154;RotationUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-3456.254,-1425.709;Inherit;False;Property;_TintIntensity;Tint Intensity;17;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;209;-3147.121,-1443.239;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;210;-2988.901,-1605.915;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;208;-3680.244,-1589.201;Inherit;False;154;RotationUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1592.795,-1739.891;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;1298.789,-1854.439;Inherit;False;31;COLOR;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;169;1290.298,-1570.902;Inherit;False;100;ROUGHNESS;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;108;1308.15,-1498.193;Inherit;False;429;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;1304.373,-1641.672;Inherit;False;99;METALLIC;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;1299.215,-1783.563;Inherit;False;79;NORMAL;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;199;1300.961,-1712.613;Inherit;False;198;EMISSION;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;1604.795,-1739.891;Float;False;True;-1;2;ASEMaterialInspector;0;12;UEPBR;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;20;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;_ZWrite;True;3;False;_ZTest;True;False;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;7;True;1;d3d11;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;_ZWrite;True;3;False;_ZTest;True;False;0;False;;0;False;;True;1;LightMode=UniversalForwardOnly;False;False;0;;0;0;Standard;41;Workflow;1;0;Surface;0;0;  Refraction Model;0;0;  Blend;0;0;Two Sided;1;0;Fragment Normal Space,InvertActionOnDeselection;0;0;Forward Only;1;638212689254420843;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;  Use Shadow Threshold;0;0;Receive Shadows;1;0;GPU Instancing;0;638212689290978635;LOD CrossFade;0;638212689302901036;Built-in Fog;0;638212689306658885;_FinalColorxAlpha;0;0;Meta Pass;0;638212689316928552;Override Baked GI;0;0;Extra Pre Pass;0;0;DOTS Instancing;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;Debug Display;0;638215442796365794;Clear Coat;0;638215442492209112;0;10;False;True;True;True;False;False;True;True;False;False;False;;True;0
Node;AmplifyShaderEditor.SamplerNode;11;-3384.102,-1249.2;Inherit;True;Property;_Normal;Normal;4;3;[NoScaleOffset];[Normal];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;38;-3680.346,-1154.312;Inherit;False;Property;_NormalIntensity;Normal Intensity;21;1;[Header];Create;True;1;(Bump);0;0;False;1;Space(10);False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;3;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;4;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;5;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;6;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormalsOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;7;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;False;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;8;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;9;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;-2778.911,-441.1729;Inherit;False;181;RoughnessMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;174;-2777.217,-554.9041;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;183;-3638.911,-538.1723;Inherit;False;181;RoughnessMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;221;-2943.3,-628.0177;Inherit;False;2;0;FLOAT;0.001;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;217;-3679.573,-464.5075;Inherit;False;Property;_RoughnessMapContrast;Roughness Map Contrast;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;73;-2553.16,-559.8332;Inherit;False;Property;_OnlyRoughnessMap;Only Roughness Map;22;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;96;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;219;-3417.3,-610.0178;Inherit;False;Property;_BaseRoughness;Base Roughness;28;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;236;-3133.41,-604.9921;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;249;-3390.608,-482.3774;Inherit;False;CheapContrast;-1;;18;30753e70b0452ae4088682fe4d196fa8;0;2;33;FLOAT;0;False;11;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;194;-2499.606,-122.2463;Inherit;False;Property;_OnlyEmissionMap;Only Emission Map;36;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;192;-2211.397,-195.7854;Inherit;False;Property;_UseEmission;Use Emission;35;0;Create;True;0;0;0;False;2;Header((Emission));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;205;-3477.048,-1611.71;Inherit;True;Property;_TintMask;Tint Mask;15;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-1857.658,-1557.016;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;36;-1623.609,-1561.644;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;207;-1397.37,-1579.374;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;213;-1639.331,-1488.964;Inherit;False;212;TintMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;25;-2125.612,-1539.113;Inherit;False;Property;_TintColor;Tint Color;16;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0.7805109,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;260;-3065.348,-1248.651;Inherit;False;BaseNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;129;-3099.308,-2030.201;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-2844.309,-2100.202;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;-3056.092,-2105.319;Inherit;False;160;UVsTilling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;162;-2845.259,-2008.752;Inherit;False;161;UVsOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;144;-2644.265,-2099.64;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-2503.273,-2104.744;Inherit;False;BaseUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;152;-2182.924,-1941.681;Inherit;False;Property;_RotationAngle;Rotation Angle;11;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;151;-2080.436,-2120.95;Inherit;False;14;BaseUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;149;-2043.54,-2035.474;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-2287.541,-2017.474;Inherit;False;Property;_RotationCenterY;Rotation Center Y;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-2287.545,-2088.023;Inherit;False;Property;_RotationCenterX;Rotation Center X;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;147;-1580.475,-2119.674;Inherit;False;Property;_UseUVsRotation;Use UVs Rotation;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;154;-1306.825,-2120.11;Inherit;False;RotationUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;253;-1848.492,-2058.22;Inherit;False;CustomUVsRotation;-1;;22;877275968accb0648ab275fa4725ca8c;0;3;49;FLOAT2;0,0;False;33;FLOAT2;0,0;False;11;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;256;-2978.06,201.9031;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;280;-2968.933,315.5065;Inherit;False;276;DetailUVsTilling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;257;-2684.991,201.5017;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;282;-2686.933,290.5064;Inherit;False;277;DetailUVsOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;281;-2444.933,201.5064;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;283;-2303.933,196.5064;Inherit;False;DetailUVsBase;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;285;-2074.716,212.3347;Inherit;False;Property;_DetailRotationX;Detail Rotation X;42;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;286;-2074.715,285.7361;Inherit;False;Property;_DetailRotationY;Detail Rotation Y;43;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;284;-1838.203,267.3856;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;279;-1559.555,244.9085;Inherit;False;CustomUVsRotation;-1;;31;877275968accb0648ab275fa4725ca8c;0;3;49;FLOAT2;0,0;False;33;FLOAT2;0,0;False;11;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;288;-1839.223,358.1185;Inherit;False;Property;_DetailRotationAngle;Detail Rotation Angle;44;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;274;-3393.467,218.8095;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;275;-3394.467,310.8098;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;276;-3227.838,214.3315;Inherit;False;DetailUVsTilling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;277;-3228.802,305.5101;Inherit;False;DetailUVsOffset;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-616.0063,-1557.526;Inherit;False;Property;_Saturate;Saturate;20;0;Create;True;0;0;0;False;0;False;1;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;287;-1836.226,182.9654;Inherit;False;283;DetailUVsBase;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;75;-2123.772,-1776.037;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;74;-2647.819,-1776.017;Inherit;False;Property;_BaseColor;BaseColor;13;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;19;-1717.945,-1657.643;Inherit;False;Property;_OnlyAlbedoMap;Only Albedo Map;12;0;Create;True;0;0;0;False;4;Header(_________________________________________________________________________________________________);Header(Custom Params);Header((Base Color));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;212;-2823.164,-1610.549;Inherit;False;TintMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;325;365.9663,-1657.71;Inherit;False;PBRColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1165.09,-1553.769;Inherit;False;Property;_Contrast;Contrast;19;0;Create;True;0;0;0;False;0;False;0;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-3680.396,-925.7864;Inherit;False;154;RotationUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;71;-3151.094,-897.2552;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-3151.411,-827.2698;Inherit;False;AOMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;-2982.226,-901.8911;Inherit;False;RoughnessMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;179;-3149.732,-975.6454;Inherit;False;MetallicMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-3480.013,-948.7923;Inherit;True;Property;_MRA;MRA;5;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;97;-1788.314,-804.5735;Inherit;False;179;MetallicMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;171;-1786.8,-921.6396;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;96;-1576.94,-926.3076;Inherit;False;Property;_OnlyMRAMap;Only MRA Map;22;0;Create;True;0;0;0;False;2;Header((Reflection));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;180;-2656.55,-902.8464;Inherit;False;179;MetallicMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;225;-2684.925,-822.0854;Inherit;False;Property;_MetallicMapContrast;Metallic Map Contrast;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;226;-2125.939,-977.4437;Inherit;False;Property;_BaseMetallic;Base Metallic;24;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;251;-2419.729,-840.0909;Inherit;False;CheapContrast;-1;;32;30753e70b0452ae4088682fe4d196fa8;0;2;33;FLOAT;0;False;11;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;350;-1330.079,-925.6138;Inherit;False;PBRMetallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;379;-2304.116,-559.8503;Inherit;False;PBRRoughness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;310;-3143.242,1105.882;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;313;-3371.11,939.361;Inherit;False;Property;_DetailBaseColor;Detail Base Color;50;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;314;-3147.111,939.361;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;316;-2913.897,944.113;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;307;-3457.559,1106.357;Inherit;True;Property;_DetailAlbedo;Detail Albedo;51;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;323;-2563.204,1175.787;Inherit;False;296;DetailMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;322;-2355.67,1157.537;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;318;-2205.832,1152.818;Inherit;False;DetailColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;315;-2673.951,1082.968;Inherit;False;Property;_OnlyDetailAlbedoMap;Only Detail Albedo Map;49;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;346;-3367.971,1842.305;Inherit;False;CheapContrast;-1;;34;30753e70b0452ae4088682fe4d196fa8;0;2;33;FLOAT;0;False;11;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;342;-3686.169,1860.31;Inherit;False;Property;_DetailMetallicMapContrast;Detail Metallic Map Contrast;59;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;339;-2715.042,1761.754;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;344;-3035.181,1705.95;Inherit;False;Property;_BaseDetailMetallic;Base Detail Metallic;57;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;341;-3635.794,1779.548;Inherit;False;334;DetailMetallicMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;373;-2716.597,2091.499;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;370;-3369.526,2172.049;Inherit;False;CheapContrast;-1;;35;30753e70b0452ae4088682fe4d196fa8;0;2;33;FLOAT;0;False;11;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;372;-3687.724,2190.053;Inherit;False;Property;_DetailRoughnessMapContrast;Detail Roughness Map Contrast;64;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;-3630.349,2109.292;Inherit;False;333;DetailRoughnessMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;376;-3354.936,2036.796;Inherit;False;Property;_BaseDetailRoughness;Base Detail Roughness;62;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;388;-2890.052,2018.232;Inherit;False;2;0;FLOAT;0.001;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;387;-3066.751,2041.532;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;377;-2538.796,2086.024;Inherit;False;DetailRoughness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;338;-2539.241,1756.28;Inherit;False;DetailMetallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;345;-3113.509,1779.368;Inherit;False;Property;_UseDetailMetallicMapContrast;Use Detail Metallic Map Contrast;58;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;371;-3132.064,2109.113;Inherit;False;Property;_UseDetailRoughnessMapContrast;Use Detail Roughness Map Contrast;63;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;397;-505.3651,185.5357;Inherit;False;DetailUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;289;-1013.91,259.5504;Inherit;False;DetailRotationUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;309;-3691.242,1129.882;Inherit;False;289;DetailRotationUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;308;-1292.715,183.2458;Inherit;False;Property;_UseDetailRotation;Use Detail Rotation;41;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;273;-3681.467,210.8095;Inherit;False;Property;_DetailTillingandOffset;Detail Tilling and Offset;40;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;395;-982.3657,185.5357;Inherit;False;154;RotationUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;391;-3033.436,1875.223;Inherit;False;Property;_DetailMetallicMapWeight;Detail Metallic Map Weight;56;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;375;-3040.601,2202.5;Inherit;False;Property;_DetailRoughnessMapWeight;Detail Roughness Map Weight;61;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;201;1902.981,-1690.705;Inherit;False;Property;_CullMode;Cull Mode;0;2;[Header];[Enum];Create;True;2;_________________________________________________________________________________________________;Rendering Settings;0;1;UnityEngine.Rendering.CullMode;True;1;Space(10);False;2;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;2033.983,-1690.705;Inherit;False;Property;_ZWrite;ZWrite;1;1;[Toggle];Create;True;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;202;2154.983,-1690.705;Inherit;False;Property;_ZTest;ZTest;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;0;4;False;0;1;INT;0
Node;AmplifyShaderEditor.StaticSwitch;394;-755.389,185.6848;Inherit;False;Property;_DetailUVsMode;Detail UVs Mode;39;0;Create;True;0;0;0;False;4;Header(_________________________________________________________________________________________________);Header(Add Details);Header((Deatil UVs));Space(10);False;0;1;1;True;;KeywordEnum;2;MainUVs;DetailUVs;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;297;-2541.853,647.6345;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;413;-2561.906,575.7311;Inherit;False;412;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;362;-2488.776,732.3865;Inherit;False;DetailGlobalIntensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;368;-2233.989,713.9713;Inherit;False;2;0;FLOAT;0.001;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;365;-2070.353,625.2966;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;300;-2361.65,619.6345;Inherit;False;Property;_InvetDetailMask;Invet Detail Mask;46;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;328;-2773.649,732.5261;Inherit;False;Property;_DetailIntensity;Detail Intensity;47;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;331;-3180.987,621.4199;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;333;-3012.118,616.7839;Inherit;False;DetailRoughnessMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;334;-3180.623,545.0303;Inherit;False;DetailMetallicMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;406;-3181.608,687.1874;Inherit;False;DetailAOMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;412;-3181.428,761.4595;Inherit;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;398;-3698.679,616.5946;Inherit;False;397;DetailUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;-1919.813,-628.2745;Inherit;False;95;AOMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;233;-1710.329,-574.3023;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;234;-2021.328,-556.3022;Inherit;False;Property;_AOMapAdd;AO Map Add;32;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;418;-3378.189,2421.411;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;419;-3199.536,2493.122;Inherit;False;CheapContrast;-1;;37;30753e70b0452ae4088682fe4d196fa8;0;2;33;FLOAT;0;False;11;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;417;-3607.673,2367.439;Inherit;False;406;DetailAOMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;420;-3689.189,2439.411;Inherit;False;Property;_DetailAOMapAdd;Detail AO Map Add;68;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;416;-3472.629,2510.748;Inherit;False;Property;_DetailAOMapContrast;Detail AO Map Contrast;66;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;425;-2629.62,2398.529;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;421;-2926.62,2512.529;Inherit;False;Property;_DetailAOIntensity;Detail AO Intensity;67;1;[Header];Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;426;-1947.36,2368.451;Inherit;False;424;DetailAO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;427;-1946.36,2441.451;Inherit;False;101;PBRAO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;428;-1743.36,2373.451;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;292;-3506.83,593.6597;Inherit;True;Property;_DetailMask;Detail Mask;45;3;[Header];[NoScaleOffset];[SingleLineTexture];Create;True;1;(Detail Mask);0;0;False;1;Space(10);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;415;-2967.6,2416.796;Inherit;False;Property;_UseDetailAOMapContrast;Use Detail AO Map Contrast;65;0;Create;True;0;0;0;False;2;Header((Detail Ambient Occlussion));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;432;-1608.164,2373.705;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;429;-1458.922,2369.185;Inherit;False;AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;433;-1556.929,-574.4452;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;250;-1402.676,-501.5918;Inherit;False;CheapContrast;-1;;38;30753e70b0452ae4088682fe4d196fa8;0;2;33;FLOAT;0;False;11;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;232;-1612.769,-483.9661;Inherit;False;Property;_AOMapContrast;AO Map Contrast;34;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;185;-867.8158,-484.2747;Inherit;False;95;AOMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;104;-867.7599,-598.1845;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;177;-662.9534,-603.4261;Inherit;False;Property;_OnlyRoughnessMap1;Only Roughness Map;22;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;96;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;101;-427.056,-603.2021;Inherit;False;PBRAO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;222;-2165.267,-903.0258;Inherit;False;Property;_UseMetallicMapContrast;Use Metallic Map Contrast;25;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;172;-2125.804,-804.6395;Inherit;False;Property;_MetallicWeight;Metallic Weight;23;1;[Header];Create;True;1;(Metallic);0;0;False;1;Space(10);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;218;-3145.103,-537.0331;Inherit;False;Property;_UseRoughnessMapContrast;Use Roughness Map Contrast;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;175;-3089.83,-442.0238;Inherit;False;Property;_RoughnessWeight;Roughness Weight;27;1;[Header];Create;True;1;Roughness;0;0;False;1;Space(10);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;230;-1170.74,-579.9181;Inherit;False;Property;_UseAOMapContrast;Use AO Map Contrast;33;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-1169.76,-484.1843;Inherit;False;Property;_AOIntensity;AO Intensity;31;1;[Header];Create;True;1;(Ambient Occlussion);0;0;False;1;Space(10);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;261;-2638.496,1381.128;Inherit;False;260;BaseNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;262;-2643.773,1457.571;Inherit;False;259;DetailNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;435;-2632.862,1529;Inherit;False;296;DetailMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;439;-2418.156,1439.922;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;436;-2416.863,1368;Inherit;False;260;BaseNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;294;-2202.813,1412.222;Inherit;False;Property;_UseDetailNormal;Use Detail Normal;52;0;Create;True;0;0;0;False;2;Header((Detail Normal));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;79;-1920.317,1412.075;Inherit;False;NORMAL;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;352;-2258.538,1714.32;Inherit;False;350;PBRMetallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;99;-1603.744,1713.304;Inherit;False;METALLIC;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;351;-2268.532,1788.569;Inherit;False;338;DetailMetallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;353;-2048.536,1770.318;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;392;-1879.957,1713.646;Inherit;False;Property;_UseDetailMetallic;Use Detail Metallic;55;0;Create;True;0;0;0;False;2;Header((Detail Metallic));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;442;-2253.608,1861.871;Inherit;False;296;DetailMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;381;-2243.431,2129.404;Inherit;False;377;DetailRoughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;382;-2233.431,2056.317;Inherit;False;379;PBRRoughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;-1511.959,2056.68;Inherit;False;ROUGHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;383;-1986.483,2111.826;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;393;-1796.061,2056.304;Inherit;False;Property;_UseDetailRoughness;Use Detail Roughness;60;0;Create;True;0;0;0;False;2;Header((Detail Roughness));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;320;-1906.894,962.7596;Inherit;False;325;PBRColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-1156.351,963.5657;Inherit;False;COLOR;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;390;-1651.027,1023.847;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;324;-1916.353,1041.602;Inherit;False;318;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;326;-1432.365,963.3157;Inherit;False;Property;_UseDetailColor;Use Detail Color;48;0;Create;True;0;0;0;False;2;Header((Detail Color));Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;438;-1914.722,1117.211;Inherit;False;296;DetailMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;414;-2722.075,642.5386;Inherit;False;412;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;296;-1923.338,620.8743;Inherit;False;DetailMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;290;-3590.504,1424.063;Inherit;False;289;DetailRotationUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;403;-3644.854,1496.985;Inherit;False;Property;_DetailNormalIntensity;Detail Normal Intensity;54;0;Create;True;0;0;0;False;0;False;0.5;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;255;-3341.067,1401.063;Inherit;True;Property;_DetailNormal;Detail Normal;53;3;[NoScaleOffset];[Normal];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;259;-3030.257,1401.29;Inherit;False;DetailNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;443;-2208.522,2201.317;Inherit;False;296;DetailMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;445;-2629.743,2510.568;Inherit;False;296;DetailMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;444;-2413.526,2398.829;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;424;-2259.916,2394.511;Inherit;False;DetailAO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
WireConnection;158;0;157;1
WireConnection;158;1;157;2
WireConnection;159;0;157;3
WireConnection;159;1;157;4
WireConnection;161;0;159;0
WireConnection;160;0;158;0
WireConnection;191;0;187;0
WireConnection;196;0;195;0
WireConnection;189;0;191;0
WireConnection;189;1;190;0
WireConnection;197;0;196;0
WireConnection;197;1;189;0
WireConnection;198;0;192;0
WireConnection;187;1;188;0
WireConnection;34;0;10;0
WireConnection;76;0;75;0
WireConnection;76;1;34;0
WireConnection;62;1;23;0
WireConnection;62;2;48;0
WireConnection;54;0;46;0
WireConnection;45;0;77;0
WireConnection;45;1;54;0
WireConnection;23;1;19;0
WireConnection;23;0;207;0
WireConnection;78;1;77;0
WireConnection;78;0;45;0
WireConnection;77;1;23;0
WireConnection;77;0;62;0
WireConnection;10;1;156;0
WireConnection;209;0;205;1
WireConnection;209;1;20;0
WireConnection;210;1;205;1
WireConnection;210;2;209;0
WireConnection;1;0;33;0
WireConnection;1;1;80;0
WireConnection;1;2;199;0
WireConnection;1;3;170;0
WireConnection;1;4;169;0
WireConnection;1;5;108;0
WireConnection;11;1;37;0
WireConnection;11;5;38;0
WireConnection;174;0;221;0
WireConnection;174;1;218;0
WireConnection;174;2;175;0
WireConnection;221;1;236;0
WireConnection;73;1;174;0
WireConnection;73;0;182;0
WireConnection;236;0;219;0
WireConnection;249;33;183;0
WireConnection;249;11;217;0
WireConnection;194;1;197;0
WireConnection;194;0;189;0
WireConnection;192;1;193;0
WireConnection;192;0;194;0
WireConnection;205;1;208;0
WireConnection;67;0;34;0
WireConnection;67;1;25;0
WireConnection;36;0;67;0
WireConnection;207;0;19;0
WireConnection;207;1;36;0
WireConnection;207;2;213;0
WireConnection;260;0;11;0
WireConnection;133;0;164;0
WireConnection;133;1;129;0
WireConnection;144;0;133;0
WireConnection;144;1;162;0
WireConnection;14;0;144;0
WireConnection;149;0;132;0
WireConnection;149;1;150;0
WireConnection;147;1;151;0
WireConnection;147;0;253;0
WireConnection;154;0;147;0
WireConnection;253;49;151;0
WireConnection;253;33;149;0
WireConnection;253;11;152;0
WireConnection;257;0;256;0
WireConnection;257;1;280;0
WireConnection;281;0;257;0
WireConnection;281;1;282;0
WireConnection;283;0;281;0
WireConnection;284;0;285;0
WireConnection;284;1;286;0
WireConnection;279;49;287;0
WireConnection;279;33;284;0
WireConnection;279;11;288;0
WireConnection;274;0;273;1
WireConnection;274;1;273;2
WireConnection;275;0;273;3
WireConnection;275;1;273;4
WireConnection;276;0;274;0
WireConnection;277;0;275;0
WireConnection;75;0;74;0
WireConnection;19;1;76;0
WireConnection;19;0;34;0
WireConnection;212;0;210;0
WireConnection;325;0;78;0
WireConnection;71;0;12;2
WireConnection;95;0;12;3
WireConnection;181;0;71;0
WireConnection;179;0;12;1
WireConnection;12;1;40;0
WireConnection;171;0;226;0
WireConnection;171;1;222;0
WireConnection;171;2;172;0
WireConnection;96;1;171;0
WireConnection;96;0;97;0
WireConnection;251;33;180;0
WireConnection;251;11;225;0
WireConnection;350;0;96;0
WireConnection;379;0;73;0
WireConnection;310;0;307;0
WireConnection;314;0;313;0
WireConnection;316;0;314;0
WireConnection;316;1;310;0
WireConnection;307;1;309;0
WireConnection;322;0;315;0
WireConnection;322;1;323;0
WireConnection;318;0;322;0
WireConnection;315;1;316;0
WireConnection;315;0;310;0
WireConnection;346;33;341;0
WireConnection;346;11;342;0
WireConnection;339;0;344;0
WireConnection;339;1;345;0
WireConnection;339;2;391;0
WireConnection;373;0;388;0
WireConnection;373;1;371;0
WireConnection;373;2;375;0
WireConnection;370;33;369;0
WireConnection;370;11;372;0
WireConnection;388;1;387;0
WireConnection;387;0;376;0
WireConnection;377;0;373;0
WireConnection;338;0;339;0
WireConnection;345;1;341;0
WireConnection;345;0;346;0
WireConnection;371;1;369;0
WireConnection;371;0;370;0
WireConnection;397;0;394;0
WireConnection;289;0;308;0
WireConnection;308;1;287;0
WireConnection;308;0;279;0
WireConnection;394;1;395;0
WireConnection;394;0;289;0
WireConnection;297;0;414;0
WireConnection;362;0;328;0
WireConnection;368;1;362;0
WireConnection;365;0;300;0
WireConnection;365;1;368;0
WireConnection;300;1;413;0
WireConnection;300;0;297;0
WireConnection;331;0;292;2
WireConnection;333;0;331;0
WireConnection;334;0;292;1
WireConnection;406;0;292;3
WireConnection;412;0;292;4
WireConnection;233;0;184;0
WireConnection;233;1;234;0
WireConnection;418;0;417;0
WireConnection;418;1;420;0
WireConnection;419;33;418;0
WireConnection;419;11;416;0
WireConnection;425;1;415;0
WireConnection;425;2;421;0
WireConnection;428;0;426;0
WireConnection;428;1;427;0
WireConnection;292;1;398;0
WireConnection;415;1;418;0
WireConnection;415;0;419;0
WireConnection;432;0;428;0
WireConnection;429;0;432;0
WireConnection;433;0;233;0
WireConnection;250;33;433;0
WireConnection;250;11;232;0
WireConnection;104;1;230;0
WireConnection;104;2;106;0
WireConnection;177;1;104;0
WireConnection;177;0;185;0
WireConnection;101;0;177;0
WireConnection;222;1;180;0
WireConnection;222;0;251;0
WireConnection;218;1;183;0
WireConnection;218;0;249;0
WireConnection;230;1;433;0
WireConnection;230;0;250;0
WireConnection;439;0;261;0
WireConnection;439;1;262;0
WireConnection;439;2;435;0
WireConnection;294;1;436;0
WireConnection;294;0;439;0
WireConnection;79;0;294;0
WireConnection;99;0;392;0
WireConnection;353;0;352;0
WireConnection;353;1;351;0
WireConnection;353;2;442;0
WireConnection;392;1;352;0
WireConnection;392;0;353;0
WireConnection;100;0;393;0
WireConnection;383;0;382;0
WireConnection;383;1;381;0
WireConnection;383;2;443;0
WireConnection;393;1;382;0
WireConnection;393;0;383;0
WireConnection;31;0;326;0
WireConnection;390;0;320;0
WireConnection;390;1;324;0
WireConnection;390;2;438;0
WireConnection;326;1;320;0
WireConnection;326;0;390;0
WireConnection;296;0;365;0
WireConnection;255;1;290;0
WireConnection;255;5;403;0
WireConnection;259;0;255;0
WireConnection;444;0;425;0
WireConnection;444;1;445;0
WireConnection;424;0;444;0
ASEEND*/
//CHKSM=50048712E3E19B89BF2659EB72508A783F01290C