// www.gamelogic.co.za

Shader "Gamelogic/Unlit Color Shape/Rose"
{
	Properties
	{
		_Color("Color", Color) = (1, 1, 1, 1)
		_k("k", Int) = 1
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Transparent"
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
			
			#include "UnityCG.cginc"
			#include "ShapeFunctions.cginc"		

			float4 _Color;
			int _k;
			
			fixed4 frag (VertexUV i) : SV_Target
			{
				fixed4 color = _Color;
				color.a = color.a * GetRoseAlpha(i.uv, _k);

				return color;
			}
			ENDCG
		}
	}
}
