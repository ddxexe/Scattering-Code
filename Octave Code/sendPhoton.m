function result = sendPhoton(pos_x, pos_y, scatter_angle, xrange,xreg,yrange,yreg)
  voxel_width = xrange/xreg;
  voxel_height = yrange/yreg;
  
  current_voxel = ceil(pos_y/voxel_height)*xreg + ceil(pos_x/voxel_width);
  
  %Identifies the next pixel/voxel our photon will pass through
  nextVoxel = findNextVoxel(x_pos, y_pos, scatter_angle, voxel_width_voxel_height)
  
  %Checks if this new voxel is consistent with boundary conditions
  valid = valid_pos(xreg, yreg, nextVoxel, scatter_angle);
  
  
  %Checks if the photon scatters with the nearest particle 
  scatter = checkIfScattered(index);
  
  
result = [nextVoxel, index] ;
endfunction
