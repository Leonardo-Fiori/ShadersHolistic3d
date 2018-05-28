Shader "Custom/SnowEffect" {

	Properties{
		_SnowColor("Snow color", Color) = (1, 1, 1, 1)
		_MainTex("MainTexture", 2D) = "white" {}
		_Bump("BumpTex", 2D) = "bump" {}
		_SnowDirection("Snow direction", Vector) = (0, 1, 0)
		_BumpAmount("Snow Bump", Float) = 0
		_SnowLevel("Amount of Snow", Range(1, -1)) = 0
	}

	SubShader{

		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Lambert

		half4 _SnowColor;
		sampler2D _MainTex;
		sampler2D _Bump;
		half3 _SnowDirection;
		fixed _SnowLevel;
		float _BumpAmount;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Bump;
			float3 worldNormal;
			INTERNAL_DATA
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			// Salva il colore del pixel
			half4 tex = tex2D(_MainTex, IN.uv_MainTex);

			// Applica la normalmap
			o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));

			// WorldNormalVector recupera worldNormal; INTERNAL_DATA dalla struct
			// dot è l'operatore punto tra normale del mondo e vettore neve
			// restituisce < 0 se l'angolo tra i due è > di 90, viceversa se è < 90, 0 se è 90
			if (dot(WorldNormalVector(IN, o.Normal), _SnowDirection) >= _SnowLevel)
			{
				o.Albedo = _SnowColor.rgb;
			}
			else
			{
				o.Albedo = tex.rgb;
			}
		}
	ENDCG
	}
}