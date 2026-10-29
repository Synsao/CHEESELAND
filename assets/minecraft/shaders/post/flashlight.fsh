#version 330

#moj_import <minecraft:globals.glsl>

uniform sampler2D InSampler;

in vec2 texCoord;

out vec4 fragColor;

const float targetBrightnes = 3.5;

void main() {
	vec2 uv = texCoord;

	// Get aspect ratio
	vec2 textureRes = textureSize(InSampler, 0);
	float aspectRatio = textureRes.x / textureRes.y;
	
	vec4 color = texture(InSampler, uv);
	
	float brightnes = targetBrightnes + sin(GameTime * 10000) * 0.1 + sin(GameTime * 20000) * 0.05 + sin(GameTime * 40000) * 0.025 + sin(GameTime * 80000) * 0.0125;
	
	// Create flashlightBrightnes
	uv += vec2(-0.5, -0.5);
	float baseGradient = distance(uv * vec2(aspectRatio, 1), vec2(0, 0)) * 4; // Create base gradient
	baseGradient = -min(baseGradient, 1)+1; // Invert gradient
	float flashlightBrightnes = baseGradient * brightnes; // Brightness
	flashlightBrightnes += 1;
	
	vec4 gameFlashColor = color * vec4(flashlightBrightnes);
	
	fragColor = gameFlashColor;
}