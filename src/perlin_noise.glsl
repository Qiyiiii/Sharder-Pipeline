// Given a 3d position as a seed, compute a smooth procedural noise
// value: "Perlin Noise", also known as "Gradient noise".
//
// Inputs:
//   st  3D seed
// Returns a smooth value between (-1,1)
//
// expects: random_direction, smooth_step
float perlin_noise( vec3 st) 
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  // Equation from pg 276 in textbook
  // solid noise
  int x0 = int(floor(st.x));
  int x1 = x0 + 1;
  int y0 = int(floor(st.y));
  int y1 = y0+1;
  int z0 = int(floor(st.z));
  int z1 = z0 + 1;

  //https://en.wikipedia.org/wiki/Perlin_noise
  // Determine interpolation weights
  float sx = st.x - float(x0);
  float sy = st.y - float(y0);
  float sz = st.z - float(z0);

  // 8 points generated from x0, x1, y0, y1, z0, z1
  // they will be used to compute grid point gradients
  vec3 p0 = vec3(x0, y0, z0);
  vec3 p1 = vec3(x1, y0, z0);
  vec3 p2 = vec3(x0, y1, z0);
  vec3 p3 = vec3(x1, y1, z0);
  vec3 p4 = vec3(x0, y0, z1);
  vec3 p5 = vec3(x1, y0, z1);
  vec3 p6 = vec3(x0, y1, z1);
  vec3 p7 = vec3(x1, y1, z1);

  //random gradient:
  vec3 g0 = random_direction(p0);
  vec3 g1 = random_direction(p1);
  vec3 g2 = random_direction(p2);
  vec3 g3 = random_direction(p3);
  vec3 g4 = random_direction(p4);
  vec3 g5 = random_direction(p5);
  vec3 g6 = random_direction(p6);
  vec3 g7 = random_direction(p7);

  // Compute the distance vector
  vec3 d0 = st - p0;
  vec3 d1 = st - p1;
  vec3 d2 = st - p2;
  vec3 d3 = st - p3;
  vec3 d4 = st - p4;
  vec3 d5 = st - p5;
  vec3 d6 = st - p6;
  vec3 d7 = st - p7;

  // Compute the dot-product for dot gradient
  float n0 = dot(g0, d0);
  float n1 = dot(g1, d1);
  // Determine interpolation weights
  vec3 s = smooth_step(st - vec3(x0, y0, z0));
  //https://registry.khronos.org/OpenGL-Refpages/gl4/html/mix.xhtml
  // Interpolate between grid point gradients
  float ix0 = mix(n0,n1,s.x);
  float n2 = dot(g2, d2);
  float n3 = dot(g3, d3);
  float ix1 = mix(n2,n3,s.x);
  float n4 = dot(g4, d4);
  float n5 = dot(g5, d5);
  float ix2 = mix(n4,n5,s.x);
  float n6 = dot(g6, d6);
  float n7 = dot(g7, d7);
  float ix3 = mix(n6,n7,s.x);

  float iy0 = mix(ix0, ix1, s.y);
  float iy1 = mix(ix2, ix3, s.y);

  float value = mix(iy0, iy1, s.z);

  // To make it in range 0 to 1, multiply by 0.5 and add 0.5
  // while value > 1 or value < 0:
  //  value = value * 0.5 + 0.5



  return value;
  /////////////////////////////////////////////////////////////////////////////
}

