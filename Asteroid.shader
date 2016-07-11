// www.gamelogic.co.za

Shader "Gamelogic/Unlit Color Shape/Asteroid"
{
	Properties
	{
		_Color("Color", Color) = (1, 1, 1, 1)
		_k("k", Int) = 1
		_p("p", float) = 1
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
			float _p;
			
			fixed4 frag (VertexUV i) : SV_Target
			{
				fixed4 color = _Color;
				color.a = color.a*GetAsteroidAlpha(i.uv, _k, _p);

				return color;
			}
			ENDCG
		}
	}
}
