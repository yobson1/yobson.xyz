// yoinked from https://www.shadertoy.com/view/MdfcRS
// see also analytical derivatives version: https://www.shadertoy.com/view/XdlyzS

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
precision highp float;
uniform vec2 u_resolution;
uniform float u_time;

float noise3( vec3 x ) {
    vec3 p = floor(x),f = fract(x);

    f = f*f*(3.-2.*f);  // or smoothstep     // to make derivative continuous at borders

#define hash3(p)  fract(sin(1e3*dot(p,vec3(1,57,-13.7)))*4375.5453)        // rand

    return mix( mix(mix( hash3(p+vec3(0,0,0)), hash3(p+vec3(1,0,0)),f.x),       // triilinear interp
                    mix( hash3(p+vec3(0,1,0)), hash3(p+vec3(1,1,0)),f.x),f.y),
                mix(mix( hash3(p+vec3(0,0,1)), hash3(p+vec3(1,0,1)),f.x),
                    mix( hash3(p+vec3(0,1,1)), hash3(p+vec3(1,1,1)),f.x),f.y), f.z);
}

#define noise(x) (noise3(x)+noise3(x+11.5)) / 2. // pseudoperlin improvement from foxes idea

float speed = .03;
float scroll_speed = 0.1;
void main() // ------------ draw isovalues
{
    vec2 U = gl_FragCoord.xy * 8./u_resolution.y;
    U += u_time*scroll_speed;
    float n = noise(vec3(U,speed*u_time)),
          v = sin(6.28*10.*n);
    v = smoothstep(-1.,1., .7*abs(v)/fwidth(v));  // first try with (0.,1. was not so good )
    float b = 0.9; // background darkness
    gl_FragColor = vec4(1.-v*b, 1.-v*b, 1.-v*b, 1);
}
