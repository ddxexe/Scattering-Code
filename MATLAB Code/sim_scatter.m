function result=simScatter(m,x,phiSteps,thetaSteps,x_range,y_range,z_range,x_reg,y_reg,z_reg,r,photons)
  heatmap = zeros(x_reg,y_reg,z_reg);
  heatmap2 = zeros(1,photons);
  positions=make_network2(x_range,x_reg,y_range,y_reg,z_range,z_reg,r);
  
  %Defines the width, height, and depth of each voxel
  %Usually v_w = v_h = v_d

  
  photon_counter = 0;
  scattered = false;
  
  loop_voxel_find = true;
  reset_path = false;
  %Repeats a certain number of times
    x_pos = x_range/2 ;
    y_pos = y_range/3  - rand();
    z_pos = z_range * rand();
    scatter_phi = 2*pi*rand();
    scatter_theta = pi/2;
    valid_voxel = false;
    loop_voxel_find = true;
    valid_voxel == false;
    loop_voxel_find = true;
    new_photon = true;
  while photon_counter < photons,
    if new_photon == true;
      x_pos = x_range/2 ;
      y_pos = y_range/3  - rand();
      z_pos = z_range * rand();
      scatter_phi = 2*pi*rand();
      scatter_theta = pi/2;
      valid_voxel = true;
      loop_voxel_find = true;
      new_photon  = false;
    endif
    
    while and(loop_voxel_find == true, reset_path == false, photon_counter < photons,
      valid_voxel == true),
      next_voxel_info = find_next_voxel(x_pos, y_pos, z_pos, x_range, y_range, 
      z_range, x_reg,y_reg,z_reg,scatter_phi, scatter_theta);
      voxel_index = next_voxel_info(1);
      x_pos = next_voxel_info(2);
      y_pos = next_voxel_info(3);
      z_pos = next_voxel_info(4) ;
      scatter_phi = next_voxel_info(5);
      scatter_theta = next_voxel_info(6);
      valid_voxel = next_voxel_info(7);
      
      if valid_voxel == 0,
          if rand < 1,
          photon_counter++;
          new_photon = true;
          
          else,
                 
          backscatter_coords=backscatter(x_pos,y_pos,z_pos,x_range,y_range,z_range,scatter_phi,scatter_theta);
          x_pos = backscatter_coords(1);
          y_pos = backscatter_coords(2);
          z_pos = backscatter_coords(3);
          
          scatter_phi = backscatter_coords(4);
          scatter_theta = backscatter_coords(5);
         endif
         
         
      endif
        
        
      
      
      if valid_voxel == 1,
        loop_voxel_find = false;
      endif

    endwhile
    
    if and(new_photon == false, reset_path == false, valid_voxel == true, loop_voxel_find == false),
      scattered = check_if_scattered(x_pos,y_pos,z_pos,
      scatter_phi, scatter_theta, positions(1,voxel_index),positions(2,voxel_index),positions(3,voxel_index),r);
      if and(scattered == 1,voxel_index > 0),
        scatter_phi = tetascan_dist4(m,x,phiSteps);
        scatter_theta = rand*pi;
        zindex = ceil(voxel_index/(x_reg*y_reg));
        yindex = ceil((voxel_index - ((zindex-1)*(x_reg*y_reg)))/x_reg);
        xindex = voxel_index - (zindex-1)*x_reg*y_reg - (yindex-1)*x_reg;
       
        heatmap(xindex,yindex,zindex)++;
        
        heatmap2(1,photon_counter+1) = voxel_index;
        
        adj_angle_data =adj_coord(x_pos,y_pos,z_pos,
        positions(1,voxel_index), positions(2,voxel_index),positions(3,voxel_index),
        scatter_phi, scatter_theta);
        
        scatter_phi = adj_angle_data(1);
        scatter_theta = adj_angle_data(2);
        scattered = 0;

      endif
      
      if scattered == 0,
        loop_voxel_find = true;
      endif
    endif
  endwhile
  
  
  for i = 1:z_reg,
    file_string = strcat('scatter_distribution', num2str(i) ,'.csv')
    csvwrite(file_string,heatmap(:,:,i));

  endfor
      

    scatter3(positions(1,:,:), positions(2,:,:), positions(3,:,:));
    
 
  result = heatmap; 
endfunction 