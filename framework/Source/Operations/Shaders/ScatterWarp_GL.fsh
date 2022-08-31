varying vec2 textureCoordinate;
uniform sampler2D inputImageTexture;

uniform float inputScatterRadius;

//based on https://www.shadertoy.com/view/ltB3zD - the additional seed
float noise(vec2 co) {
    vec2 seed = vec2(sin(co.x), cos(co.y));
    return fract(sin(dot(seed ,vec2(12.9898,78.233))) * 43758.5453);
}

vec2 scatter(float radius, vec2 co) {
    float offsetX = radius * (-1.0 + noise(co) * 2.0);
    float offsetY = radius * (-1.0 + noise(co.yx) * 2.0);
    return vec2(co.x + offsetX, co.y + offsetY);
}

void main (void) {
    vec2 co = scatter(inputScatterRadius, textureCoordinate);
    
    gl_FragColor = texture2D(inputImageTexture, co);
}
