function result = check_dist(photon_x, photon_y, adj_voxel_pos, r)
  voxel = 0;

  d_x = (photon_x - adj_voxel_pos(1)).^2;
  d_y = (photon_y - adj_voxel_pos(2)).^2;
  r;
  if sqrt(d_x + d_y) < r, 
    voxel = adj_voxel_pos;
  endif
  
  
result = voxel;
endfunction