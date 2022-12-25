// Add (hard code) an orbiting (point or directional) light to the scene. Light
// the scene using the Blinn-Phong Lighting Model.
//
// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform bool is_moon;
// Inputs:
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in; 
in vec4 view_pos_fs_in; 
// Outputs:
out vec3 color;
// expects: PI, blinn_phong
void main()
{
  /////////////////////////////////////////////////////////////////////////////

  float p = 1000; //1000 phong
  float theta = 2 * M_PI * animation_seconds / 8; // one orbit per 8 s

  vec4 light_pos = vec4(6*cos(theta), 5, 6*sin(theta), 1); //light position corresponding to time
  
  
  vec4 light = view * light_pos;

  vec3 light_d = light.xyz - view_pos_fs_in.xyz; //light direction
  
  vec3 n = normalize(normal_fs_in); //get n from normal_fs_in and normalize
  vec3 v = normalize(pos_fs_in.xyz); //get v from view_fs_in and normalize
  vec3 l = normalize(light_d); //light direction

  vec3 ka;
  vec3 ks;
  vec3 kd;
  if (is_moon){ //if moon
    ka = vec3(0.01,0.01,0.01);
    kd = vec3(0.5, 0.5, 0.5); //gray
    ks = vec3(1,1,1); //pure white light response
  }
  else{
    ka = vec3(0.01,0.01,0.01);
    kd = vec3(0.1,0.1,1); //blue
    ks = vec3(1,1,1);
  }

  color = blinn_phong(ka, kd, ks, p, n, v, l);
  /////////////////////////////////////////////////////////////////////////////
}
