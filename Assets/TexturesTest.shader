Shader "Holistic/TexturesTest" {

	Properties {
		_MyColor ("Example Color", Color) = (1,1,1,1)
		_MyTextureDiffuse ("Diffuse Texture", 2D) = "white" {}
		_MyTextureEmissive ("Emissive Texture", 2D) = "black" {} // black è il fallback color se non viene scelta la texture
	}

	SubShader {

		CGPROGRAM
		
		#pragma surface surf Lambert

		fixed4 _MyColor;
		sampler2D _MyTextureDiffuse;
		sampler2D _MyTextureEmissive;

		struct Input {
			float2 uv_MyTextureDiffuse;
			float2 uv_MyTextureEmissive;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MyTextureDiffuse, IN.uv_MyTextureDiffuse).rgb;
			o.Emission = tex2D(_MyTextureEmissive, IN.uv_MyTextureEmissive).rgb;
		}
		ENDCG

	}

	FallBack "Diffuse"
}
