function result = findNextVoxel(x_pos, y_pos, scatter_angle, xreg, voxel_width,voxel_height)
  new = false;
  %This is a temporary value
  diag = 0.1 * sqrt(voxel_width^2 + voxel_height^2);


  
  %Sets initial x and y voxel indexes for the starting position 
  init_x = floor(x_pos/voxel_width)+1;
  init_y = floor(y_pos/voxel_height)+1;
  
  
  
  orig_x = x_pos
  orig_y = y_pos
  %Sets default values for the next voxel if conditions are never met 
  
  while new == false,

    %Shifts photon position
    x_pos += diag * cos(scatter_angle);
    y_pos  += diag * sin(scatter_angle);
    
    %Translates x coordinate to voxel index
    voxel_x = floor(x_pos/voxel_width) + 1;
 
  
    %Translates y coordinate to voxel index
    voxel_y = floor(y_pos/voxel_height);   
    angle_case = floor(scatter_angle/90) + 1;
    next_voxel_x = voxel_x;
    next_voxel_y = voxel_y;

    diff_x = x_pos - orig_x;
    
    diff_y = y_pos - orig_y;
  #Checks to see if the position has rolled over to a new voxel
    switch(angle_case)

      %Angle between 0 and 90 degrees
      case 1
        if or(diff_x >= voxel_width, diff_y >= voxel_height),
          x_pos
          y_pos
          next_voxel_x = floor(x_pos/voxel_width) + 1
          next_voxel_y = floor(y_pos/voxel_height)
          new = true;
        endif
      
    %Angle between 90 and 180 degrees
    case 2
      if or(diff_x >= voxel_width, diff_y <= voxel_height),
        next_voxel_x = floor(x_pos/voxel_width)+1
        next_voxel_y = floor(y_pos/voxel_height)
        new = true
      endif
      
      
    %Angle between 180 and 270 degrees 
    case 3
    "3"
      if or(diff_x <=  voxel_width, diff_y <= voxel_height),
        next_voxel_x = floor(x_pos/voxel_width)+1
        next_voxel_y = floor(y_pos/voxel_height)
        new = true;
      endif

    %Angle between 270and 360 degrees 
    case 4
    "4"
      if or(diff_x >= voxel_width, diffS_y <= voxel_height),
        next_voxel_x = floor(x_pos/voxel_height)+1
        next_voxel_y = floor(y_pos/voxel_height)
        new = true;
      endif
  endswitch 
  new_voxel_index = next_voxel_y * xreg + next_voxel_x;
  endwhile 
  
#Returns the newest voxel to check for
#Returns when it detects we are in a different voxel than before
result = new_voxel_index;
endfunction
