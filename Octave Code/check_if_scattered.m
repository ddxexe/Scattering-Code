function result = check_if_scattered(photon_x,photon_y,photon_z,particle_x,particle_y,particle_z,r)
  scattered = false;
  
  photon_x;
  photon_y;
  photon_z;
  
  particle_x;
  particle_y;
  particle_z;
  
  dist = sqrt((photon_x-particle_x)^2 + (photon_y-particle_y)^2 + (photon_z-particle_z)^2);
  

  if dist < r,
    scattered = true;
  endif
  
  result = scattered;
  
endfunction