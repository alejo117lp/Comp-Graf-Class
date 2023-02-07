Shader "Customs/SimpleParticleScroll.shader"
{
    Properties
    { 
        _MainTex("Main Texture", 2D) = "White" {}
        }

    SubShader
    {
        Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalRenderPipeline" "Queue"="Transparent"}

        Blend One One
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"            

            struct Attributes
            {
                float4 positionOS   : POSITION;
                float4 texcoord     : TEXCOORD0;
                half4 color         : COLOR;
            };

            struct Varyings
            {
                float4 positionHCS  : SV_POSITION;
                float4 texcoord     : TEXCOORD0;
                half4 color         : COLOR;
            };

            sampler2D _MainTex;

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.texcoord = IN.texcoord;
                OUT.color = IN.color;
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                half4 col = tex2D(_MainTex, IN.texcoord.xy + IN.texcoord.zw);
                return half4(col.rgb * col.a * IN.color, col.a);
            }
            ENDHLSL
        }
    }
}