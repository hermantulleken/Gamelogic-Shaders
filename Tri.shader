// www.gamelogic.co.za

Shader "Gamelogic/Unlit Color Shape/Tri"
{
	Properties
	{
		_Color("Color", Color) = (1, 0, 0, 1)
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
	
			fixed4 frag (VertexUV i) : SV_Target
			{
				fixed4 color = _Color;
			
				color.a = color.a * GetTriAlpha(i.uv);

				return color;
			}
			ENDCG
		}
	}
}
