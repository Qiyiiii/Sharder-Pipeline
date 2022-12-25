// Generate a procedural planet and orbiting moon. Use layers of (improved)
// Perlin noise to generate planetary features such as vegetation, gaseous
// clouds, mountains, valleys, ice caps, rivers, oceans. Don't forget about the
// moon. Use `animation_seconds` in your noise input to create (periodic)
// temporal effects.
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
// expects: model, blinn_phong, bump_height, bump_position,
// improved_perlin_noise, tangent
void main()
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  float p = 1000; //1000 phong
  float theta = 2 * M_PI * animation_seconds / 8; // one orbit per 8 s

  vec4 light_pos = vec4(6*cos(theta), 5, 6*sin(theta), 1); //light position corresponding to time
  
  
  vec4 light = view * light_pos;

  vec3 light_d = light.xyz - view_pos_fs_in.xyz;


  vec3 T, B; //from the github page :Bump and normal maps
  tangent(sphere_fs_in, T, B); //get tangent and bitangent vector
  float epsi = 0.001;
  vec3 bump_posi = bump_position(is_moon, sphere_fs_in);
  vec3 b_n = cross((bump_position(is_moon, sphere_fs_in + T*epsi)-bump_position(is_moon, sphere_fs_in))/epsi,
  (bump_position(is_moon, sphere_fs_in + B*epsi)-bump_position(is_moon, sphere_fs_in))/epsi);
  //By abuse of notation, we'll make sure that this approximate perceived normal is unit length by dividing by its length:
  b_n = normalize(b_n); 

  

  
  vec3 n = normalize(normal_fs_in); //get n from normal_fs_in and normalize
  vec3 v = normalize(pos_fs_in.xyz); //get v from view_fs_in and normalize
  vec3 l = normalize(light_d); //light direction

  vec3 ka;
  vec3 ks;
  vec3 kd;

  float bump_h = bump_height(is_moon, sphere_fs_in);
  if (is_moon){ //if moon
    ka = vec3(0.01,0.01,0.01);
    kd = vec3(0.5, 0.5, 0.5); //gray
    ks = vec3(1,1,1); //pure white light response
  }
  else{
    if (bump_h > 0 && bump_h < 0.08){
    ka = vec3(0.01,0.01,0.01); //land
    kd = vec3(0.1,0.4,0.4); //green dark
    ks = vec3(1,1,1);
    }
    else if (bump_h > 0){ //high land
    ka = vec3(0.01,0.01,0.01);
    kd = vec3(0.4,0.4,0); //yellow dark
    ks = vec3(1,1,1);
    }
    
    else{ //sea
    ka = vec3(0.01,0.01,0.01);
    kd = vec3(0.1,0.1,1); //blue
    ks = vec3(1,1,1);}
  }
  // float noise = abs((1 + sin(50 * (sphere_fs_in.z + improved_perlin_noise(7 * sphere_fs_in)))/3));
  //k1 = 50, k2= 7, w =3
  

  color = blinn_phong(ka, kd , ks, p, normalize(b_n + n), v, l);

  if (!is_moon){ //cloud on planet
    // times vec3(1, 5, 1) into position for cloud so that cloud don't stick together
    float cloud =  improved_perlin_noise( vec3(1, 5, 1)*(rotate_about_y(animation_seconds * 2 * M_PI / 8) * vec4(sphere_fs_in, 1)).xyz);
    //using generated texture to be cloud! create new postion for cloud that rotate
    if (cloud > 0.01){ //if it is high enough
      ka =  vec3(1,1,1); //white
      kd =  vec3(1,1,1) * cloud;
      ks = vec3(0,0,0);
      color += blinn_phong(ka, kd, ks, p, n, v, l)*3; //improve indensity a little
      }
    
  }
  /////////////////////////////////////////////////////////////////////////////
}
