varying vec2 textureCoordinate;
uniform sampler2D inputImageTexture;

uniform vec2 uOffset; //像素步长
uniform float progress;

vec2 circle(float start, float points, float point) {
    float rad = (3.141592 * 2.0 * (1.0 / points)) * (point * start);
    return vec2(sin(rad), cos(rad));
}

void processBlur(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy;
    float start = 2.0 / 14.0;
    vec2 scale = 0.66 * 4.0 * 2.0 * uOffset.xy * progress;
    
    vec4 N0 = texture2D(inputImageTexture, uv + circle(start, 14.0, 0.0) * scale);
    vec4 N1 = texture2D(inputImageTexture, uv + circle(start, 14.0, 1.0) * scale);
    vec4 N2 = texture2D(inputImageTexture, uv + circle(start, 14.0, 2.0) * scale);
    vec4 N3 = texture2D(inputImageTexture, uv + circle(start, 14.0, 3.0) * scale);
    vec4 N4 = texture2D(inputImageTexture, uv + circle(start, 14.0, 4.0) * scale);
    vec4 N5 = texture2D(inputImageTexture, uv + circle(start, 14.0, 5.0) * scale);
    vec4 N6 = texture2D(inputImageTexture, uv + circle(start, 14.0, 6.0) * scale);
    vec4 N7 = texture2D(inputImageTexture, uv + circle(start, 14.0, 7.0) * scale);
    vec4 N8 = texture2D(inputImageTexture, uv + circle(start, 14.0, 8.0) * scale);
    vec4 N9 = texture2D(inputImageTexture, uv + circle(start, 14.0, 9.0) * scale);
    vec4 N10 = texture2D(inputImageTexture, uv + circle(start, 14.0, 10.0) * scale);
    vec4 N11 = texture2D(inputImageTexture, uv + circle(start, 14.0, 11.0) * scale);
    vec4 N12 = texture2D(inputImageTexture, uv + circle(start, 14.0, 12.0) * scale);
    vec4 N13 = texture2D(inputImageTexture, uv + circle(start, 14.0, 13.0) * scale);
    vec4 N14 = texture2D(inputImageTexture, uv);
    
    vec4 color = vec4(0.0);
    color = (N0 + N1 + N2 + N3 + N4 + N5 + N6 + N7 + N8 + N9 + N10 + N11 + N12 + N13 + N14) / 15.0;
    fragColor = color;
}

void main() {
    processBlur(gl_FragColor, textureCoordinate);
}
