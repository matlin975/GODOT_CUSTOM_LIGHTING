
shader_type canvas_item;
//render_mode blend_mul;
//render_mode blend_add;
//render_mode blend_premul_alpha;
//render_mode blend_disabled;

const float bands[8] = {0.0, 0.1, 0.2, 0.35, 0.5, 0.65, 0.8, 0.99};
const float strengths[8] = {0.27, 0.27, 0.32, 0.4, 0.5, 0.6, 0.62, 0.68};

uniform float gamma;

void fragment()
{	
	vec2 uv = SCREEN_UV;
	vec4 tex = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	float energy = (tex.r+tex.g+tex.b)/3.0;
	
	for (int i = 0; i < 8; i++){
		if (energy >= bands[i]){

//			COLOR.rgb = tex.rgb*0.5 + (tex.rgb * strengths[i]*1.5);
//			COLOR.rgb = tex.rgb*strengths[i] + (tex.rgb * strengths[i]*gamma);
			COLOR.rgb = tex.rgb*strengths[i]*gamma*1.1;
//			if (i == 0){
//				COLOR.rgb = tex.rgb*0.2;
//			}
//			COLOR.rgb = tex.rgb * strengths[i]*2.5;
//			COLOR.rgb = textureLod(tex, uv, 0.0).rgb;
		}
	}
	

//	COLOR.rgb = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;
//	COLOR.a = 0.5;
//	vec2 uv = SCREEN_UV;
//	uv -= mod(uv, vec2(size_x, size_y));
//	COLOR.rgb = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;
	
//	COLOR.rgb = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;
	
}