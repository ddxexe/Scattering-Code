function result = findNextVoxel2(x_pos, y_pos, scatter_angle, xreg, v_w,v_h)
  new = false;
  %This is a temporary value
  diag = 0.1 * sqrt(v_w^2 + v_h^2);

  scatter_angle;

  %Sets default values for the next voxel if conditions are never met 
      angle_case = floor(scatter_angle/(pi/2)) + 1;
      neg_x_bound = x_pos - mod(x_pos,v_w);
      pos_x_bound = neg_x_bound + v_w;
      neg_y_bound = y_pos - mod(y_pos,v_h);
      pos_y_bound =  neg_y_bound + v_h;
      
      
  while new == false,
    x_pos += diag * cos(scatter_angle);
    y_pos  += diag * sin(scatter_angle);
  
  switch(angle_case)
    case 1
      if or(x_pos > pos_x_bound, y_pos > pos_y_bound),
        new = true;
      endif
    case 2
      if or(x_pos < pos_x_bound, y_pos > pos_y_bound),
        new = true;
      endif
    case 3
      if or(x_pos < pos_x_bound, y_pos < pos_y_bound),
        new = true;
      endif
    case 4
      if or(x_pos > pos_x_bound, y_pos < pos_y_bound),
        new = true;
      endif
  endswitch
  endwhile 
  if new == true;
    next_voxel_x = floor(x_pos/v_w) + 1;
    next_voxel_y = floor(y_pos/v_h);
    
    new_voxel_index =  next_voxel_y * xreg + next_voxel_x;
  endif
#Returns the newest voxel to check for
#Returns when it detects we are in a different voxel than before
result = [new_voxel_index, x_pos, y_pos, scatter_angle];
endfunction
