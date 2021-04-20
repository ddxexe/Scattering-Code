function result = find_next_voxel(x_pos,y_pos,z_pos,x_range,y_range,z_range,x_reg,y_reg,z_reg,scatter_phi,scatter_theta)

%x_pos,y_pos,z_pos are the (rectangular) coordinates tracking the photon's position throughout the particle network
%x_range,y_range,z_range,x_reg,y_reg,z_reg all serve the same purpose as they did in "create_network()"

photon_info = zeros(1,7);


%Width, height, and depth of each voxel
vox_x = x_range/x_reg;
vox_y = y_range/y_reg;
vox_z = z_range/z_reg;


%Used to identify what voxel a certain position is in
min_vox_x = floor(x_pos/vox_x);
min_vox_y = floor(y_pos/vox_y);
min_vox_z = floor(z_pos/vox_z);
max_vox_x = min_vox_x + 1;
max_vox_y = min_vox_y + 1;
max_vox_z = min_vox_z + 1;


%photon_dist is the distance a photon will move per incrementation
voxel_diag = sqrt(vox_x^2 + vox_y^2 + vox_z^2);
photon_dist = 0.1*voxel_diag;

valid_voxel = true;
new = false;

while new == false


    x_pos += photon_dist*sin(scatter_theta)*cos(scatter_phi);
    y_pos += photon_dist*sin(scatter_theta)*sin(scatter_phi);
    z_pos += photon_dist*cos(scatter_theta);

    rel_x = x_pos/vox_x;
    rel_y = y_pos/vox_y;
    rel_z = z_pos/vox_z;

    if rel_x < min_vox_x || rel_x > max_vox_x || rel_y < min_vox_y || rel_y > max_vox_y ||
    rel_z < min_vox_z || rel_z > max_vox_z
        new = true;
    end
end

if new == true
    photon_info(1,1) = floor(rel_z)*x_reg*y_reg
    +floor(rel_y)*x_reg+ceil(rel_x);
    
    photon_info(1,2) = x_pos;
    photon_info(1,3) = y_pos;
    photon_info(1,4) = z_pos;

    photon_info(1,5) = sc_phi;
    photon_info(1,6) = scatter_theta;

    if x_pos < 0 || x_pos >= x_range  || y_pos < 0 ||
    y_pos >= y_range || z_pos < 0 || z_pos >= z_range
        valid_voxel = false;
    end

    photon_info(1,7) = valid_voxel;
end

result = photon_info;

end