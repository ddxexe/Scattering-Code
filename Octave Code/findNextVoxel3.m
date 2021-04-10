function result = findNextVoxel3(x_pos, y_pos,z_pos,xrange,yrange,zrange, scatter_phi, scatter_theta, xreg,yreg, v_w,v_h,v_d)
  new = false;
  %Magnitude of distance the photon moves incrementally
  diag = 0.1 * sqrt(v_w^2 + v_h^2+v_d^2);
  
  
  %Coordinates of the x,y,and z bounds for the voxel the photon is currently in
  neg_x_bound = x_pos - mod(x_pos,v_w)
  pos_x_bound = neg_x_bound + v_w
  neg_y_bound = y_pos - mod(y_pos,v_h)
  pos_y_bound =  neg_y_bound + v_h
  neg_z_bound = z_pos - mod(z_pos,v_d)
  pos_z_bound = neg_z_bound + v_d
  

  %Sets default values for the next voxel if conditions are never met 
  x_case = 1;
  y_case = 1;
  z_case = 1;
  
  while new == false, 
    
    
    %Immediately kicks out if the photon exits the bounds 
    if or(x_pos < 0, x_pos > xrange, y_pos < 0, y_pos > yrange, z_pos < 0, z_pos > zrange),
      new = true
    endif
    
    
    %Updates the x,y,and z positions of the photon

    x_pos += diag * sin(scatter_theta) * cos(scatter_phi)
    y_pos += diag * sin(scatter_theta) * sin(scatter_phi);
    z_pos += diag * cos(scatter_theta);
    
    %Used in conjunction with lines 15-17
    %Determines if the x,y,and z components of the direction
    %are positive or negative
    if abs(pi - scatter_phi) < pi/2,
      x_case = 2;
    endif
    
    if scatter_phi > pi,
      y_case = 2;
    endif
    
    if scatter_theta > pi/2,
      z_case = 2;
    endif
  
    switch(x_case)
      case 1
        if x_pos > pos_x_bound,
          new = true;
        endif
      case 2 
        if x_pos < neg_x_bound,
          new = true;
        endif
      endswitch 
     
     
    switch(y_case)
      case 1
        if y_pos > pos_y_bound,
          new = true;
        endif
      case 2
        if y_pos < neg_y_bound,
          new = true;
        endif
    endswitch 

    
    switch(z_pos)
      case 1
        if z_pos > pos_z_bound,
          new = true ;
        endif
      
      case 2
        if z_pos < neg_z_bound,
          new = true;
        endif
      endswitch 
  endwhile
      
  if new == true;
    next_voxel_x = floor(x_pos/v_w) + 1
    next_voxel_y = floor(y_pos/v_h)
    next_voxel_z = floor(z_pos/v_d)
    new_voxel_index =  (next_voxel_z * xreg * yreg) + (next_voxel_y * xreg)  + next_voxel_x;
  endif
#Returns the newest voxel to check for
#Returns when it detects we are in a different voxel than before
result = [new_voxel_index, x_pos, y_pos, z_pos];
endfunction
