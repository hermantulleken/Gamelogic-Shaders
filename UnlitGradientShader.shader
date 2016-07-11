Shader "Gamelogic/Unlit/UnlitGradientShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1, 0, 0, 1)
		_ColorLow("Low Color", Color) = (0, 0, 0, 1)
		_ColorHigh("High Color", Color) = (1, 1, 1, 1)
	}

	SubShader
	{
		Tags 
		{
			"RenderType"="Transparent" 
			"Queue" = "Transparent" 
			"IgnoreProjector" = "True" 
		}

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _Color;
			float4 _ColorLow;
			float4 _ColorHigh;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				float grey = (col.r + col.g + col.b) / 3;

				if (grey < 0.5f)
				{
					float t = grey * 2;
					col.rgb = lerp(_ColorLow, _Color.rgb, t);
				}
				else
				{
					float t = (grey - 0.5) * 2;
					col.rgb = lerp(_Color.rgb, _ColorHigh, t);
				}
				
				UNITY_APPLY_FOG(i.fogCoord, col);

				return col;
			}
			ENDCG
		}
	}
}
