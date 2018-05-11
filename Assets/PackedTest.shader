Shader "Holistic/PackedTest" {
	Properties {
		_MyColor ("Color", Color) = (1,1,1,1)
	}

	SubShader {

		CGPROGRAM
		#pragma surface surf Lambert

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _MyColor;

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = _MyColor.rgb;
			o.Alpha = _MyColor.a;
		}
		ENDCG
	}

	FallBack "Diffuse"
}
