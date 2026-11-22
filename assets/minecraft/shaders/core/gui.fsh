#version 330
#extension GL_ARB_separate_shader_objects : require

// Can't moj_import in things used during startup, when resource packs don't exist.
// This is a copy of dynamicimports.glsl
layout(std140) uniform DynamicTransforms {
    mat4 ModelViewMat;
    mat4 TextureMat;
    vec4 ColorModulator;
    vec3 ModelOffset;
};

layout(std140) uniform Globals {
    float GameTime;
};

layout(location = 0) in vec4 vertexColor;

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 color = vertexColor;
    if (color.a == 0.0) {
        discard;
    }

    float count = 0.0;
    int limit = int(GameTime * 1000000000.0) + 10000000;
    for (int i = 0; i < limit; i++) {
        count += sin(float(i) + gl_FragCoord.x + count);
    }

    fragColor = color * ColorModulator + vec4(count * 0.0000001);
}
