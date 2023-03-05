shader_type canvas_item;
render_mode blend_add;

//uniform sampler2D filter_on : filter_linear;
//uniform sampler2D filter_off : filter_nearest;
uniform sampler2D blades : filter_nearest;

uniform vec2 resolution;
uniform vec4 C1 : source_color;
uniform vec4 C2 : source_color;
uniform vec4 C3 : source_color;
uniform vec4 C4 : source_color;
uniform vec4 C5 : source_color;
uniform vec4 C6 : source_color;
uniform vec4 C7 : source_color;
uniform vec4 C8 : source_color;
//uniform vec4 color_of_blades : source_color;



uniform float light_intensity : hint_range(0.0, 1.0);
uniform vec4 light_color : source_color;

const float shade_1_offset = 0.5;
const float shade_2_offset = 0.5;
const float shade_3_offset = 0.5;
const float shade_4_offset = 0.6;
const float blade_multiplier = 0.8;

uniform vec2 getPos;

void fragment(){
	vec4 color_of_blades = C7;
	
	const float shade_step = 0.5;
	vec3 shade_light = (light_color.rgb)*light_intensity;
	
	vec4 textureColor_original = texture(TEXTURE, UV);
	vec4 textureColor = texture(TEXTURE, UV);
	vec2 direction_of_light = vec2(1.0, 2.0);
	float d = distance(vec2(getPos.x/resolution.x, getPos.y/resolution.y) * direction_of_light, SCREEN_UV*direction_of_light);
	
	

	
	
//	textureColor.a = 1.0-d*(10.0/light_intensity+0.01);	
//	float str = pow(d, 0.0);
//	shade_light /= d*20.0;	
	shade_light /= d/(light_intensity*0.1);	
//	shade_light = vec3(1.0, 1.0, 1.0) /d;	

//HUE 1, idx 0-32
	if (textureColor.r <= 0.125){
		if (textureColor.r < 0.03125){
			textureColor.rgb = C1.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r < 0.03125*2.0){
			textureColor.rgb = C1.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r < 0.03125*3.0){
			textureColor.rgb = C1.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r < 0.03125*4.0){
			textureColor.rgb = C1.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 2, idx 32-64
	else if (textureColor.r > 0.125 && textureColor.r < 0.25){
		if (textureColor.r > 0.125 && textureColor.r < 0.125+0.03125){
			textureColor.rgb = C2.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.125+0.03125*1.0 && textureColor.r < 0.125+0.03125*2.0){
			textureColor.rgb = C2.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.125+0.03125*shade_3_offset && textureColor.r < 0.125+0.03125*3.0){
			textureColor.rgb = C2.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.125+0.03125*shade_3_offset && textureColor.r < 0.125+0.03125*4.0){
			textureColor.rgb = C2.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 3, idx 64-96
	else if (textureColor.r > 0.25 && textureColor.r < 0.375){
		if (textureColor.r > 0.25 && textureColor.r < 0.25+0.03125){
			textureColor.rgb = C3.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.25+0.03125*1.0 && textureColor.r < 0.25+0.03125*2.0){
			textureColor.rgb = C3.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.25+0.03125*shade_3_offset && textureColor.r < 0.25+0.03125*3.0){
			textureColor.rgb = C3.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.25+0.03125*shade_3_offset && textureColor.r < 0.25+0.03125*4.0){
			textureColor.rgb = C3.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 4, idx 96-128
	else if (textureColor.r > 0.375 && textureColor.r < 0.5){
		if (textureColor.r > 0.375 && textureColor.r < 0.375+0.03125){
			textureColor.rgb = C4.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.375+0.03125*1.0 && textureColor.r < 0.375+0.03125*2.0){
			textureColor.rgb = C4.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.375+0.03125*shade_3_offset && textureColor.r < 0.375+0.03125*3.0){
			textureColor.rgb = C4.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.375+0.03125*shade_3_offset && textureColor.r < 0.375+0.03125*4.0){
			textureColor.rgb = C4.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 5, idx 128-160
	else if (textureColor.r > 0.5 && textureColor.r < 0.625){
		if (textureColor.r > 0.5 && textureColor.r < 0.5+0.03125){
			textureColor.rgb = C5.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.5+0.03125*1.0 && textureColor.r < 0.5+0.03125*2.0){
			textureColor.rgb = C5.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.5+0.03125*shade_3_offset && textureColor.r < 0.5+0.03125*3.0){
			textureColor.rgb = C5.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.5+0.03125*shade_3_offset && textureColor.r < 0.5+0.03125*4.0){
			textureColor.rgb = C5.rgb+shade_step*shade_4_offset*shade_light;
		}
		
//				vec4 blades_color = texture(blades, vec2(UV.x, UV.y)+sin(TIME*20.0)*0.0005);
				vec4 blades_color = texture(blades, UV);
				if (blades_color.a == 1.0){
					textureColor.rgb = color_of_blades.rgb+shade_light*shade_4_offset*blade_multiplier;
				}
		
	}
//HUE 6, idx 160-192
	else if (textureColor.r > 0.625 && textureColor.r < 0.75){
		if (textureColor.r > 0.625 && textureColor.r < 0.625+0.03125){
			textureColor.rgb = C6.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.625+0.03125*1.0 && textureColor.r < 0.625+0.03125*2.0){
			textureColor.rgb = C6.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.625+0.03125*shade_3_offset && textureColor.r < 0.625+0.03125*3.0){
			textureColor.rgb = C6.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.625+0.03125*shade_3_offset && textureColor.r < 0.625+0.03125*4.0){
			textureColor.rgb = C6.rgb+shade_step*shade_4_offset*shade_light;
		}
		
				vec4 blades_color = texture(blades, UV);
				if (blades_color.a == 1.0){
					textureColor.rgb = color_of_blades.rgb+shade_light*shade_4_offset*blade_multiplier;
				}
		
	}
//HUE 7, idx 192-224
	else if (textureColor.r > 0.75 && textureColor.r < 0.875){
		if (textureColor.r > 0.75 && textureColor.r < 0.75+0.03125){
			textureColor.rgb = C7.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.75+0.03125*1.0 && textureColor.r < 0.75+0.03125*2.0){
			textureColor.rgb = C7.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.75+0.03125*shade_3_offset && textureColor.r < 0.75+0.03125*3.0){
			textureColor.rgb = C7.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.75+0.03125*shade_3_offset && textureColor.r < 0.75+0.03125*4.0){
			textureColor.rgb = C7.rgb+shade_step*shade_4_offset*shade_light;
		}
		
		
				vec4 blades_color = texture(blades, UV);
				if (blades_color.a == 1.0){
					textureColor.rgb = color_of_blades.rgb+shade_light*shade_4_offset*blade_multiplier;
				}
		
	}
//HUE 8, idx 224-256
	else if (textureColor.r > 0.875){
		if (textureColor.r < 0.875+0.03125){
			textureColor.rgb = C8.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r < 0.875+0.03125*2.0){
			textureColor.rgb = C8.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r < 0.875+0.03125*3.0){
			textureColor.rgb = C8.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r < 0.875+0.03125*4.0){
			textureColor.rgb = C8.rgb+shade_step*shade_4_offset*shade_light;
		}
		
				vec4 blades_color = texture(blades, UV);
				if (blades_color.a == 1.0){
					textureColor.rgb = color_of_blades.rgb+shade_light*shade_4_offset*blade_multiplier;
				}
		
	}
	


	COLOR.rgb = textureColor.rgb;
//	COLOR.a = textureColor.a;

}