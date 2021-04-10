function result = checkIfScattered(next_voxel_info,positions,r)
  scatter = false;
  
  pos_index = next_voxel_info(1);
  proj_angle = next_voxel_info(4);
  
  photon_x = next_voxel_info(2);
  photon_y = next_voxel_info(3);
  
  particle_x = positions(1, pos_index);
  particle_y = positions(2, pos_index);
  particle_z = positions(3, pos_index);
  
  
  
  proj_photon_x = photon_x + ((particle_y - photon_y)/(tan(proj_angle)));
  proj_photon_y = (tan(proj_angle) * (particle_x - photon_x)) + photon_y;
  
  abs(proj_photon_x - particle_x);
  abs(proj_photon_y - particle_y);
 
  
  if or(abs(proj_photon_x - particle_x) < r, abs(proj_photon_y - particle_y) < r),
    scatter = true;
  endif
  

  result = scatter; 
endfunction
