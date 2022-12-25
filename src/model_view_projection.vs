// Determine the perspective projection (do not conduct division) in homogenous
// coordinates. If is_moon is true, then shrink the model by 70%, shift away
// from the origin by 2 units and rotate around the origin at a frequency of 1
// revolution per 4 seconds.
//
// Uniforms:
//                  4x4 view transformation matrix: transforms "world
//                  coordinates" into camera coordinates.
uniform mat4 view;
//                  4x4 perspective projection matrix: transforms
uniform mat4 proj;
//                                number of seconds animation has been running
uniform float animation_seconds;
//                     whether we're rendering the moon or the other object
uniform bool is_moon;
// Inputs:
//                  3D position of mesh vertex
in vec3 pos_vs_in; 
// Ouputs:
//                   transformed and projected position in homogeneous
//                   coordinates
out vec4 pos_cs_in; 
// expects: PI, model
void main()
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  
  mat4 mod = model(is_moon, animation_seconds);
  //if moon, then rotate, else return identity matrix

  // shrink the model by 70%
  mat4 sca = uniform_scale(0.3);

  // shift away from the origin by 2 units in x axis
  // mat4 shi = translate(vec3(2,0,0)); 
  
  // sincne shift will change x and z coordinates
  float theta = 2 * M_PI * animation_seconds / 4; //since 4 second a loop
  // imagine x,z form a circle
  
  vec4 shi = vec4(2 * sin(theta), 0, 2 * cos(theta), 0); 
  //counter clockwise


  if (is_moon){ //if it is moon
    
    pos_cs_in =  proj * view * (mod * sca * vec4(pos_vs_in,1.0)+ shi); 
    }
    //follow first scale, then shift then rotate
  else{ //if not moon
    pos_cs_in =  proj * view * vec4(pos_vs_in,1.0) ; 
  }
 
    
  
  /////////////////////////////////////////////////////////////////////////////
}
