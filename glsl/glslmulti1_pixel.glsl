//voronoi effect

uniform float uAspect;
uniform float uPointSize;
uniform int uNumPoints;

out vec4 fragColor;

#define SRC 0
#define POINTS 1

float circle(vec2 uv, vec2 center, float radius) {
    vec2 aspect_uv = uv;
    aspect_uv.y *= uAspect; //aspect correct our uv values used to draw circles at points
    vec2 aspect_center = center;
    aspect_center.y *= uAspect; // aspect correct the circle center coordinates as well

    //draw circle
    float c = smoothstep(radius, radius - .001, distance(aspect_uv, aspect_center));
    return c;
}

void main()
{
    vec2 uv = vUV.st;

    // initialize values
    float render_points = 0;
    float minDist = 1000000.0;
    vec2 closestPoint = vec2(-10, -10);

    // loop through all points
    for (int i = 0; i < uNumPoints; i++) {
        vec2 point = texelFetch(sTD2DInputs[POINTS], ivec2(i, 0), 0).rg;

        // calculate distance from pixel to point
        float dist = distance(uv, point);

        // check distance against current closest point
        if (dist < minDist) {
            // update if this point is closest of the sampled ones
            closestPoint = point;
            minDist = dist;

            // accumulate circle render
            render_points += circle(uv, point, uPointSize / 1000);
        }
    }

    // Get the color for the closest point
    vec4 color = texture(sTD2DInputs[SRC], closestPoint);
    color += vec4(render_points);   

    // Final output color
    fragColor = TDOutputSwizzle(color);
}
