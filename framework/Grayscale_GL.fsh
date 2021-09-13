varying vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform float intensity;
uniform int type;

void main()
{
    vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    
    vec4 grayColor = textureColor;
    if(type == 0) {
        grayColor = vec4(vec3((textureColor.r + textureColor.g + textureColor.b)/3.0),textureColor.a);
    } else if (type == 1) {
        float gray = 0.299*textureColor.r + 0.587*textureColor.g + 0.114*textureColor.b;
        grayColor = vec4(vec3(gray),textureColor.a);
    } else {
        float gray = (max(max(textureColor.r,textureColor.g),textureColor.b) + min(min(textureColor.r,textureColor.g),textureColor.b))/2.0;
        grayColor = vec4(vec3(gray),textureColor.a);
    }
    
    gl_FragColor = vec4(mix(textureColor.rgb, grayColor.rgb, grayColor.a * intensity), textureColor.a);
}

