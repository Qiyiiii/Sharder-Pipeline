// Generate a pseudorandom unit 3D vector
// 
// Inputs:
//   seed  3D seed
// Returns psuedorandom, unit 3D vector drawn from uniform distribution over
// the unit sphere (assuming random2 is uniform over [0,1]²).
//
// expects: random2.glsl, PI.glsl
vec3 random_direction( vec3 seed)
{
  /////////////////////////////////////////////////////////////////////////////
  vec2 r_point = random2(seed); //random 2d point

  //https://en.wikipedia.org/wiki/Spherical_coordinate_system
  // sphere coordinates system
  float theta = M_PI * r_point.x; // 0 - 180 degree
  float phi = 2*M_PI * r_point.y; // 0 - 360 degree

  float x = sin(theta)*cos(phi);
  float y = sin(theta)*sin(phi);
  float z = cos(theta);

 
  return vec3(x,y,z);
  /////////////////////////////////////////////////////////////////////////////
}
