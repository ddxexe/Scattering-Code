function result = sim_scatter(m,x,phi_steps,theta_steps,
x_range,y_range,z_range,x_reg,y_reg,z_reg,r,photons)

heatmap_1 = zeros(1,x_reg*y_reg*z_reg);
heatmap_2 = zeros(1,photons);


positions = make_network(x_range,x_reg,y_range,y_reg,z_range,z_reg,r);

photon_counter = 1;
scattered = false;

loop_voxel_search = true;
reset_photon_path = false;





valid_voxel = false;
new_photon = true;

while photon_counter < photons

    if new_photon == true

        %Determines the initial position of the photon
        %Most common configurations are either a uniform or a circular
        %Gaussian distribution 

        x_pos = x_range/2+rand;
        y_pos = y_range/3-rand;
        zpos = z_range*rand;

        scatter_phi = pi/3;
        scatter_theta = rand/4;

        valid_voxel = true;
        new_photon = false;
    end

    while loop_voxel_search == true && reset_path == false, photon_counter < photons
    && valid_voxel == true


        next_voxel_info = find_next_voxel(x_pos,y_pos,z_pos,
        x_range,y_range,z_range, x_reg,y_reg,z_reg,scatter_phi,scatter_theta)

        voxel_index = next_voxel_info(1);

        x_pos = next_voxel_info(2);
        y_pos = next_voxel_info(3);
        z_pos = next_voxel_info(4);

        scatter_phi = next_voxel_info(5);
        scatter_theta = next_voxel_info(6);

        valid_voxel = next_voxel_info(7);

        if valid_voxel == false
            photon_counter++;
            new_photon = true;
        end

        if valid_voxel == true
            loop_voxel_search = true;
        end
    
    end

    endwhile

    if!new_photon and !reset_path and !loop_voxel_find and valid_voxel
    
        scattered  = check_if_scattered(x_pos, y_pos, z_pos,
        scatter_phi, scatter_theta, positions(1,voxel_index), positions(2,voxel_index),positions(3,voxel_index));

        if scattered == 1

        heatmap(voxel_index)++;
        heatmap2(1, photon_counter+1)  = voxel_index;
        
        angle_data_1 = tetascan_dist(m,x,phiSteps);

        scatter_phi = angle_data_1(1);
        scatter_theta = angle_data_1(2);

        angle_data_2 = adj_coords(x,y,z,
        positions(1,voxel_index),positions(2,voxel_index),positions(3,voxel_index),
        scatter_phi,scatter_theta);

        
    result = heatmap_2;

end