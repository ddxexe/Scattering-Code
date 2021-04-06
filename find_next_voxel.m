function result = find_next_voxel(x_pos, y_pos, z_pos, x_range, y_range, z_range, x_reg,y_reg,z_reg,scatter_phi,scatter_theta)

photon_info = zeros(1,7);

valid_voxel = 1;

v_w = x_range/x_reg;
v_h = y_range/y_reg;
v_d = z_range/z_reg;

min_x_bound = floor(x_pos/v_w);
min_y_bound = floor(y_pos/v_h);
min_z_bound = floor(z_pos/v_d);

max_x_bound = min_x_bound + 1;
max_y_bound = min_y_bound + 1;
max_z_bound = min_z_bound + 1;

voxel_diag = sqrt(v_h^2 + v_w^2 + v_d^2);
photon_dist = 0.1*voxel_diag;

new = false;
while new == false,
  x_pos += photon_dist * sin(scatter_theta) * cos(scatter_phi)
  y_pos += photon_dist * sin(scatter_theta) * sin(scatter_phi)
  z_pos += photon_dist * cos(scatter_theta)
  
  rel_x = x_pos/v_w;
  rel_y = y_pos/v_h;
  rel_z = z_pos/v_d ;
  
  
  if or(rel_x < min_x_bound, rel_x > max_x_bound, rel_y < min_y_bound, rel_y > max_y_bound,
  rel_z < min_z_bound, rel_z > max_z_bound),
    new = true;
  endif

endwhile

if new == true,
  photon_info(1,1) = (floor(rel_z) * x_reg * y_reg) + (floor(rel_y) * x_reg) + ceil(rel_x);
  photon_info(1,2) = x_pos;
  photon_info(1,3) = y_pos;
  photon_info(1,4) = z_pos;
  photon_info(1,5) = scatter_phi;
  photon_info(1,6) = scatter_theta;
  
  if or(x_pos < 0, x_pos >= x_range, y_pos < 0, y_pos >= y_range,
    z_pos < 0, z_pos >= z_range),
    valid_voxel = 0
  endif
  
  photon_info(1,7) = valid_voxel;
endif
  
result = photon_info;


endfunction