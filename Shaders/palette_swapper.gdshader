shader_type canvas_item;
render_mode blend_mix;

uniform bool process = true;
uniform bool reverse_depth;
uniform bool outline_enabled;
uniform vec4 outline_color : source_color;
uniform float outline_width : hint_range(0.1, 2);
uniform float outline_alpha : hint_range(0.1, 1);

//uniform int numberOfHues = 8;
//uniform int numberOfShades = 4;
uniform vec4 C1 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 C2 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 C3 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 C4 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 C5 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 C6 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 C7 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 C8 : source_color = vec4(0.0, 0.0, 0.0, 1.0);

//const float hue_step_size = float(numberOfHues)/256.0;
uniform float light_intensity : hint_range(0.0, 1.0);
uniform vec4 light_color : source_color;

//const float shade_2_offset = 0.5;
//const float shade_3_offset = 1.0;
//const float shade_4_offset = 1.5;
const float shade_1_offset = 0.2;
const float shade_2_offset = 0.25;
const float shade_3_offset = 0.35;
const float shade_4_offset = 0.5;


void fragment(){
if (process){
	
	const float shade_step = 2.5;
	vec3 shade_light = (light_color.rgb)*light_intensity;
	
	vec4 referenceColors[8];
	referenceColors[0] = C1;
	referenceColors[1] = C2;
	referenceColors[2] = C3;
	referenceColors[3] = C4;
	referenceColors[4] = C5;
	referenceColors[5] = C6;
	referenceColors[6] = C7;
	referenceColors[7] = C8;
	
	vec4 textureColor = texture(TEXTURE, UV);
	textureColor.g = 0.0;
	textureColor.b = 0.0;
//	COLOR.rgb = referenceColors[int(floor(textureColor.r * float(4)* float(numberOfColors)))].rgb;
//Hue stepsize = number of hues / 256 = 0.03125, *2 to reach base color = 0.0625











if (reverse_depth == false){
//HUE 1, idx 0-32
	if (textureColor.r <= 0.125){
		if (textureColor.r < 0.03125){
			COLOR.rgb = C1.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r < 0.03125*2.0){
			COLOR.rgb = C1.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r < 0.03125*3.0){
			COLOR.rgb = C1.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r < 0.03125*4.0){
			COLOR.rgb = C1.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 2, idx 32-64
	else if (textureColor.r > 0.125 && textureColor.r < 0.25){
		if (textureColor.r > 0.125 && textureColor.r < 0.125+0.03125){
			COLOR.rgb = C2.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.125+0.03125*1.0 && textureColor.r < 0.125+0.03125*2.0){
			COLOR.rgb = C2.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.125+0.03125*shade_3_offset && textureColor.r < 0.125+0.03125*3.0){
			COLOR.rgb = C2.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.125+0.03125*shade_3_offset && textureColor.r < 0.125+0.03125*4.0){
			COLOR.rgb = C2.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 3, idx 64-96
	else if (textureColor.r > 0.25 && textureColor.r < 0.375){
		if (textureColor.r > 0.25 && textureColor.r < 0.25+0.03125){
			COLOR.rgb = C3.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.25+0.03125*1.0 && textureColor.r < 0.25+0.03125*2.0){
			COLOR.rgb = C3.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.25+0.03125*shade_3_offset && textureColor.r < 0.25+0.03125*3.0){
			COLOR.rgb = C3.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.25+0.03125*shade_3_offset && textureColor.r < 0.25+0.03125*4.0){
			COLOR.rgb = C3.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 4, idx 96-128
	else if (textureColor.r > 0.375 && textureColor.r < 0.5){
		if (textureColor.r > 0.375 && textureColor.r < 0.375+0.03125){
			COLOR.rgb = C4.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.375+0.03125*1.0 && textureColor.r < 0.375+0.03125*2.0){
			COLOR.rgb = C4.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.375+0.03125*shade_3_offset && textureColor.r < 0.375+0.03125*3.0){
			COLOR.rgb = C4.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.375+0.03125*shade_3_offset && textureColor.r < 0.375+0.03125*4.0){
			COLOR.rgb = C4.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 5, idx 128-160
	else if (textureColor.r > 0.5 && textureColor.r < 0.625){
		if (textureColor.r > 0.5 && textureColor.r < 0.5+0.03125){
			COLOR.rgb = C5.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.5+0.03125*1.0 && textureColor.r < 0.5+0.03125*2.0){
			COLOR.rgb = C5.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.5+0.03125*shade_3_offset && textureColor.r < 0.5+0.03125*3.0){
			COLOR.rgb = C5.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.5+0.03125*shade_3_offset && textureColor.r < 0.5+0.03125*4.0){
			COLOR.rgb = C5.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 6, idx 160-192
	else if (textureColor.r > 0.625 && textureColor.r < 0.75){
		if (textureColor.r > 0.625 && textureColor.r < 0.625+0.03125){
			COLOR.rgb = C6.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.625+0.03125*1.0 && textureColor.r < 0.625+0.03125*2.0){
			COLOR.rgb = C6.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.625+0.03125*shade_3_offset && textureColor.r < 0.625+0.03125*3.0){
			COLOR.rgb = C6.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.625+0.03125*shade_3_offset && textureColor.r < 0.625+0.03125*4.0){
			COLOR.rgb = C6.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 7, idx 192-224
	else if (textureColor.r > 0.75 && textureColor.r < 0.875){
		if (textureColor.r > 0.75 && textureColor.r < 0.75+0.03125){
			COLOR.rgb = C7.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r > 0.75+0.03125*1.0 && textureColor.r < 0.75+0.03125*2.0){
			COLOR.rgb = C7.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.75+0.03125*shade_3_offset && textureColor.r < 0.75+0.03125*3.0){
			COLOR.rgb = C7.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.75+0.03125*shade_3_offset && textureColor.r < 0.75+0.03125*4.0){
			COLOR.rgb = C7.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
//HUE 8, idx 224-256
	else if (textureColor.r > 0.875){
		if (textureColor.r < 0.875+0.03125){
			COLOR.rgb = C8.rgb+shade_light*shade_1_offset;
		}
		else if (textureColor.r < 0.875+0.03125*2.0){
			COLOR.rgb = C8.rgb+shade_step*shade_2_offset*shade_light;
		}
		else if (textureColor.r < 0.875+0.03125*3.0){
			COLOR.rgb = C8.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r < 0.875+0.03125*4.0){
			COLOR.rgb = C8.rgb+shade_step*shade_4_offset*shade_light;
		}
	}
}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
if (reverse_depth == true){
//HUE 1, idx 0-32
	if (textureColor.r <= 0.125){
		if (textureColor.r < 0.03125){
			COLOR.rgb = C1.rgb+shade_step*shade_4_offset*shade_light;
		}
		else if (textureColor.r < 0.03125*2.0){
			COLOR.rgb = C1.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r < 0.03125*3.0){
			COLOR.rgb = C1.rgb+shade_2_offset*shade_light;
		}
		else if (textureColor.r < 0.03125*4.0){
			COLOR.rgb = C1.rgb+shade_1_offset*shade_light;
		}
	}
//HUE 2, idx 32-64
	else if (textureColor.r > 0.125 && textureColor.r < 0.25){
		if (textureColor.r > 0.125 && textureColor.r < 0.125+0.03125){
			COLOR.rgb = C2.rgb+shade_step*shade_4_offset*shade_light;
		}
		else if (textureColor.r > 0.125+0.03125*1.0 && textureColor.r < 0.125+0.03125*2.0){
			COLOR.rgb = C2.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.125+0.03125*shade_3_offset && textureColor.r < 0.125+0.03125*3.0){
			COLOR.rgb = C2.rgb+shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.125+0.03125*shade_3_offset && textureColor.r < 0.125+0.03125*4.0){
			COLOR.rgb = C2.rgb+shade_1_offset*shade_light;
		}
	}
//HUE 3, idx 64-96
	else if (textureColor.r > 0.25 && textureColor.r < 0.375){
		if (textureColor.r > 0.25 && textureColor.r < 0.25+0.03125){
			COLOR.rgb = C3.rgb+shade_step*shade_4_offset*shade_light;
		}
		else if (textureColor.r > 0.25+0.03125*1.0 && textureColor.r < 0.25+0.03125*2.0){
			COLOR.rgb = C3.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.25+0.03125*shade_3_offset && textureColor.r < 0.25+0.03125*3.0){
			COLOR.rgb = C3.rgb+shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.25+0.03125*shade_3_offset && textureColor.r < 0.25+0.03125*4.0){
			COLOR.rgb = C3.rgb+shade_1_offset*shade_light;
		}
	}
//HUE 4, idx 96-128
	else if (textureColor.r > 0.375 && textureColor.r < 0.5){
		if (textureColor.r > 0.375 && textureColor.r < 0.375+0.03125){
			COLOR.rgb = C4.rgb+shade_step*shade_4_offset*shade_light;
		}
		else if (textureColor.r > 0.375+0.03125*1.0 && textureColor.r < 0.375+0.03125*2.0){
			COLOR.rgb = C4.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.375+0.03125*shade_3_offset && textureColor.r < 0.375+0.03125*3.0){
			COLOR.rgb = C4.rgb+shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.375+0.03125*shade_3_offset && textureColor.r < 0.375+0.03125*4.0){
			COLOR.rgb = C4.rgb+shade_1_offset*shade_light;
		}
	}
//HUE 5, idx 128-160
	else if (textureColor.r > 0.5 && textureColor.r < 0.625){
		if (textureColor.r > 0.5 && textureColor.r < 0.5+0.03125){
			COLOR.rgb = C5.rgb+shade_light*shade_4_offset*shade_light;
		}
		else if (textureColor.r > 0.5+0.03125*1.0 && textureColor.r < 0.5+0.03125*2.0){
			COLOR.rgb = C5.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.5+0.03125*shade_3_offset && textureColor.r < 0.5+0.03125*3.0){
			COLOR.rgb = C5.rgb+shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.5+0.03125*shade_3_offset && textureColor.r < 0.5+0.03125*4.0){
			COLOR.rgb = C5.rgb+shade_1_offset*shade_light;
		}
	}
//HUE 6, idx 160-192
	else if (textureColor.r > 0.625 && textureColor.r < 0.75){
		if (textureColor.r > 0.625 && textureColor.r < 0.625+0.03125){
			COLOR.rgb = C6.rgb+shade_light*shade_4_offset*shade_light;
		}
		else if (textureColor.r > 0.625+0.03125*1.0 && textureColor.r < 0.625+0.03125*2.0){
			COLOR.rgb = C6.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.625+0.03125*shade_3_offset && textureColor.r < 0.625+0.03125*3.0){
			COLOR.rgb = C6.rgb+shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.625+0.03125*shade_3_offset && textureColor.r < 0.625+0.03125*4.0){
			COLOR.rgb = C6.rgb+shade_1_offset*shade_light;
		}
	}
//HUE 7, idx 192-224
	else if (textureColor.r > 0.75 && textureColor.r < 0.875){
		if (textureColor.r > 0.75 && textureColor.r < 0.75+0.03125){
			COLOR.rgb = C7.rgb+shade_light*shade_4_offset*shade_light;
		}
		else if (textureColor.r > 0.75+0.03125*1.0 && textureColor.r < 0.75+0.03125*2.0){
			COLOR.rgb = C7.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r > 0.75+0.03125*shade_3_offset && textureColor.r < 0.75+0.03125*3.0){
			COLOR.rgb = C7.rgb+shade_2_offset*shade_light;
		}
		else if (textureColor.r > 0.75+0.03125*shade_3_offset && textureColor.r < 0.75+0.03125*4.0){
			COLOR.rgb = C7.rgb+shade_1_offset*shade_light;
		}
	}
//HUE 8, idx 224-256
	else if (textureColor.r > 0.875){
		if (textureColor.r < 0.875+0.03125){
			COLOR.rgb = C8.rgb+shade_light*shade_4_offset*shade_light;
		}
		else if (textureColor.r < 0.875+0.03125*2.0){
			COLOR.rgb = C8.rgb+shade_step*shade_3_offset*shade_light;
		}
		else if (textureColor.r < 0.875+0.03125*3.0){
			COLOR.rgb = C8.rgb+shade_2_offset*shade_light;
		}
		else if (textureColor.r < 0.875+0.03125*4.0){
			COLOR.rgb = C8.rgb+shade_1_offset*shade_light;
		}
	}
}		
	
	
	
	
	
	
	
	
	
	
	COLOR.a = textureColor.a;
	if (outline_enabled == true){
		float size_x = outline_width/float(textureSize(TEXTURE, 0).x);
		float size_y = outline_width/float(textureSize(TEXTURE, 0).y);
		vec4 sprite_color = texture(TEXTURE, UV);
		float alpha = -4.0 * sprite_color.a;
		alpha += texture(TEXTURE, UV + vec2(size_x, 0)).a;
		alpha += texture(TEXTURE, UV + vec2(-size_x, 0)).a;
		alpha += texture(TEXTURE, UV + vec2(0, size_y)).a;
		vec4 final_color = mix(COLOR, outline_color, clamp(alpha, 0, outline_alpha));
		COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0, 1));
	}	
}
}

