function result=simScatter4(m,x,phiSteps,thetaSteps,x_range,y_range,z_range,x_reg,y_reg,z_reg,r,photons)
  heatmap = zeros(1,x_reg*y_reg*z_reg);
  heatmap2 = zeros(1,photons);
  positions=make_network2(x_range,x_reg,y_range,y_reg,z_range,z_reg,r);
  
  %Defines the width, height, and depth of each voxel
  %Usually v_w = v_h = v_d

  
  photon_counter = 0;
  scattered = false;
  
  loop_voxel_find = true;
  reset_path = false;
  %Repeats a certain number of times
      x_pos = x_range/2 + rand();
    y_pos = y_range/3  - rand();
    z_pos = z_range * rand();
    scatter_phi = 2*rand()*pi;
    scatter_theta = rand()*pi;
    valid_voxel = false;
    loop_voxel_find = true;
    
        valid_voxel == false;
    loop_voxel_find = true;
    new_photon = true;
  while photon_counter < photons,
    photon_counter
    if new_photon == true;
      x_pos = x_range/2 + rand();
      y_pos = y_range/3  - rand();
      z_pos = z_range * rand();
      scatter_phi = pi/3;
      scatter_theta = rand()/4;
      valid_voxel = true;
      loop_voxel_find = true;
      new_photon  = false;
    endif
    
    while and(loop_voxel_find == true, reset_path == false, photon_counter < photons,
      valid_voxel == true),
      next_voxel_info = find_next_voxel(x_pos, y_pos, z_pos, x_range, y_range, 
      z_range, x_reg,y_reg,z_reg,scatter_phi, scatter_theta)
      "found a new voxel"      
      voxel_index = next_voxel_info(1)
      x_pos = next_voxel_info(2);
      y_pos = next_voxel_info(3);
      z_pos = next_voxel_info(4) ;
      scatter_phi = next_voxel_info(5);
      scatter_theta = next_voxel_info(6);
      valid_voxel = next_voxel_info(7);
      
      if valid_voxel == 0,
        photon_counter++;
        "out of bounds, new photon"
        new_photon = true;
      endif
      
      if valid_voxel == 1,
        loop_voxel_find = false;
      endif

    endwhile
    
    if and(new_photon == false, reset_path == false, valid_voxel == true, loop_voxel_find == false),
      scattered = check_if_scattered(x_pos,y_pos,z_pos,
      positions(1,voxel_index),positions(2,voxel_index),positions(3,voxel_index),r)
      "checking scatter"
      if scattered == 1,
        voxel_index
        heatmap(voxel_index)++;
        heatmap2(1,photon_counter) = voxel_index
        scatter_phi = tetascan_dist2(m, x, phiSteps)
        scattered = 0;

      endif
      
      if scattered == 0,
        loop_voxel_find = true;
      endif
    endif
  endwhile
  
  
      

      


    
    
   
  result = heatmap2; 
endfunction 