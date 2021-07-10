function result = check_if_scattered_local(x_pos,y_pos,z_pos,
  x_range,y_range,z_range,vx,vy,vz,positions,r)
  
  scattered = false;
  
  x_index = floor(x_pos/vx)+1;
  y_index = floor(y_pos/vy);
  z_index = floor(z_pos/vz);
  
  voxel_check_instance = (z_index*x_range*y_range)+(y_index*x_range)+x_index;
  
  positions(1,voxel_check_instance);
  
  positions(2,voxel_check_instance);
  
  positions(3,voxel_check_instance);
  d2=(positions(1,voxel_check_instance)-x_pos)^2 +(positions(2,voxel_check_instance)-y_pos)^2 + (positions(3,voxel_check_instance)-z_pos)^2;
  
  d = sqrt(d2);
  
  if d < r,
    scattered = true;
  endif 
  
  result = scattered;
endfunction
