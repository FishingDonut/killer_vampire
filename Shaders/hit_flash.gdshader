shader_type canvas_item;

uniform float flash_intensity : hint_range(0.0, 1.0);

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    color.rgb += vec3(flash_intensity);
    COLOR = color;
}
