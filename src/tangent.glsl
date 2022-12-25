// Input:
//   N  3D unit normal vector
// Outputs:
//   T  3D unit tangent vector
//   B  3D unit bitangent vector
void tangent(in vec3 N, out vec3 T, out vec3 B)
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 

  //algorithm from https://gamedev.stackexchange.com/questions/68612/how-to-compute-tangent-and-bitangent-vectors
  // and http://www.opengl-tutorial.org/intermediate-tutorials/tutorial-13-normal-mapping/
  // we choose x to calculate its cross product with N
  vec3 x = vec3(1,0,0);
  T = vec3(normalize(cross(x, N))); // cross product will produce tangent
  B = vec3(normalize(cross(N, T))); //bitangent is perpendicular to Tangent
  /////////////////////////////////////////////////////////////////////////////
}
