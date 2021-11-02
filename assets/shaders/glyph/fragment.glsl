
#version 330

uniform sampler2D glyph;

in vec2 frag_uv;
in vec4 frag_color;

out vec4 color;

void main() { color = frag_color * texture(glyph, frag_uv).rrrr; }
