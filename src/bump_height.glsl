// Create a bumpy surface by using procedural noise to generate a height (
// displacement in normal direction).
//
// Inputs:
//   is_moon  whether we're looking at the moon or centre planet
//   s  3D position of seed for noise generation
// Returns elevation adjust along normal (values between -0.1 and 0.1 are
//   reasonable.
float bump_height( bool is_moon, vec3 s)
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  float h = improved_perlin_noise(5* s); //makes more sense for planet
  h = smooth_heaviside(h, 5);
  if (abs(h)>0.1){
    return -0.1 + 0.1*(h+1); //make sure abs smaller than 0.1
  }
  return h;
  /////////////////////////////////////////////////////////////////////////////
}
