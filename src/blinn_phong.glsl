// Compute Blinn-Phong Shading given a material specification, a point on a
// surface and a light direction. Assume the light is white and has a low
// ambient intensity.
//
// Inputs:
//   ka  rgb ambient color
//   kd  rgb diffuse color
//   ks  rgb specular color
//   p  specular exponent (shininess)
//   n  unit surface normal direction
//   v  unit direction from point on object to eye
//   l  unit light direction
// Returns rgb color
vec3 blinn_phong(
  vec3 ka,
  vec3 kd,
  vec3 ks,
  float p,
  vec3 n,
  vec3 v,
  vec3 l)
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  //ambience
  vec3 rgb = 0.01 * ka ;
  rgb += kd * max(0, dot(n,l)); //Lambertian shading, normallize it
  rgb += ks *  pow(max(0.0, dot(n, normalize(v+ l))),p); //specular
  return rgb;
  /////////////////////////////////////////////////////////////////////////////
}


