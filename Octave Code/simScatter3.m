function result=simScatter3(m,x,phiSteps,thetaSteps,x_range,y_range,z_range,x_reg,y_reg,z_reg,r,photons)
  heatmap = zeros(1,x_reg*y_reg*z_reg);
  
  positions=make_network2(x_range,x_reg,y_range,y_reg,z_range,z_reg,r)
  
  %Defines the width, height, and depth of each voxel
  %Usually v_w = v_h = v_d

  
  photons_counter = 0;
  scattered = false;
  
  loop_voxel_find = true;
  %Repeats a certain number of times
  
  while photons_counter < photons,
    "reset information"
    %set initial position and angle
    x_pos = x_range/2 + rand();
    y_pos = y_range/3  - rand();
    z_pos = z_range * 0.75;
    scatter_phi = 0;
    scatter_theta = pi/4;
    
    loop_voxel_find = true;
    
    while loop_voxel_find == true,
      "finding next voxel"
      scattered = false;
      %repeat until we find a new voxel 
      next_voxel_info = find_next_voxel(x_pos, y_pos, z_pos, x_range, y_range, 
      z_range, x_reg,y_reg,z_reg,scatter_phi, scatter_theta)
      
      
      
      voxel_index = next_voxel_info(1);
      

      x_pos = next_voxel_info(2);
      y_pos = next_voxel_info(3);
      z_pos = next_voxel_info(4);
      
      scatter_phi = next_voxel_info(5);
      scatter_theta = next_voxel_info(6);
      
      valid_voxel = next_voxel_info(7);
      
      if valid_voxel == false,
        "reached bound, next photon"
        photons_counter++
        loop_voxel_find = false;
      endif
      if valid_voxel == true,
        "found a voxel"
        loop_voxel_find = false;
      endif
    endwhile  
    
    scattered = check_if_scattered(x_pos,y_pos,z_pos,
    positions(1,voxel_index), positions(2,voxel_index), positions(3,voxel_index),r);
    
    if and(scattered == true, valid_voxel == true),
      "did scatter"
      scattered;
      heatmap(voxel_index)++;
      scattered = false;
    endif
    
    
    if scattered == false,
      "did not scatter"
      scattered;
    endif
    loop_voxel_find =  true;

    
    
  endwhile 
  result = heatmap; 
endfunction 