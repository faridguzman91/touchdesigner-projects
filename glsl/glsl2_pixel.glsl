
// Example Pixel Shader

// uniform float exampleUniform;

out vec4 fragColor;
void main()
{
	vec4 color = texture(sTD2DInputs[0], vUV.st);
	
	vec2 pos = color.rg; 
	
	// wrap point locations aroud the range [0,1]
	
	pos = mod(pos, 1);
	
	color.rg = pos;
	color.b *= 0;  // clamp all positions to x,y plane
	fragColor = TDOutputSwizzle(color);
}
