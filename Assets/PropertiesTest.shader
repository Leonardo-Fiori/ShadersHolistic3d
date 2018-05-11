Shader "Holistic/PropertiesTest" {

	Properties {
		_MyColor ("Example Color", Color) = (1,1,1,1)
		_MyRange ("Example Float Range", Range(0,5)) = 1
		_MyTexture ("Example Texture", 2D) = "white" {}
		_MyCube ("Example Cube", CUBE) = "" {}
		_MyFloat ("Example Float", Float) = 0.5
		_MyVector ("Example Vector", Vector) = (0.5,1,1,1)
	}

	SubShader {

		CGPROGRAM
		
		#pragma surface surf Lambert

		fixed4 _MyColor;
		half _MyRange;
		sampler2D _MyTexture;
		samplerCUBE _MyCube;
		float _MyFloat;
		float4 _MyVector;

		struct Input {
			float2 uv_MyTexture; // prende l'uv di MyTex
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed3 color = (tex2D(_MyTexture, IN.uv_MyTexture) * _MyRange).rgb;
			//color.g = 1;
			o.Albedo = color; // tex2d restituisce il pixel della texture tenendo conto della uv attuale
			o.Albedo += _MyColor.rgb;
			o.Emission = (texCUBE(_MyCube, IN.worldRefl)).rgb; // texCUBE restituisce il pixel del cubo in base ad un vector3 che rappresenta una posizione
			//o.Albedo.g = 1;
		}
		ENDCG

	}

	FallBack "Diffuse"
}
