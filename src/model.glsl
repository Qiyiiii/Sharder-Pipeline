// Construct the model transformation matrix. The moon should orbit around the
// origin. The other object should stay still.
//
// Inputs:
//   is_moon  whether we're considering the moon
//   time  seconds on animation clock
// Returns affine model transformation as 4x4 matrix
//
// expects: identity, rotate_about_y, translate, PI
mat4 model(bool is_moon, float time)
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 


  if (is_moon) { //if object is moon then rotate
    float t = 2 * M_PI * time / 4;  //theta value should be 2 pi times seconds divide by period for the position of moon
    // in the example picture, the period of moon rotation is 4 sec
    return rotate_about_y(t); //return the rotation matrix
    
  }
  else{ //other objects that needs to be still
    return identity();
  }
  /////////////////////////////////////////////////////////////////////////////
}
