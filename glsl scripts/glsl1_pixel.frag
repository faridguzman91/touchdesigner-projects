//Adapted by Simon Alexander-Adams from https://easings.net/

#define PI 3.14159265359

float ease(float x){

      float n1 = 7.5625;
      float d1 = 2.75;

      if (x < 1 / d1) {
            return n1 * x * x;
      } else if (x < 2 / d1) {
            return n1 * (x -= 1.5 / d1) * x + 0.75;
      } else if (x < 2.5 / d1) {
            return n1 * (x -= 2.25 / d1) * x + 0.9375;
      } else {
            return n1 * (x -= 2.625 / d1) * x + 0.984375;
      }

}

out vec4 fragColor;

void main()
{
	vec4 current = texture(sTD2DInputs[0], vUV.st);
 
	current = vec4(ease(current.r),ease(current.g),ease(current.b),ease(current.a));

	fragColor = TDOutputSwizzle(current);
}
