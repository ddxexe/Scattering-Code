function result=simScatter(m,x,phiSteps,thetaSteps,xrange,yrange,zrange,xreg,yreg,zreg,r,photons)
  heatmap = zeros(1,xreg*yreg*zreg)
  
  
  %Generates a network of particles
  positions=make_network2(xrange,yrange,xreg,yreg,zrange,zreg,r);
  
  %Defines the width, height, and depth of each voxel
  %Usually v_w = v_h = v_d
  v_w = xrange/xreg;
  v_h = yrange/yreg;
  v_d = zrange/zreg;

  %Whether our voxel is in the 
  valid_voxel = false;
  scattered = false;
  in_bounds = true;
  
  for a = 1:photons,
    a
    valid_voxel = false;
    scattered = false;
    in_bounds = true;
    
    %Initial conditions of incident photon 
    x_pos = xrange/2;
    y_pos = yrange/2;
    z_pos = zrange/2;
    scatter_phi = 2*pi*rand();
    scatter_theta = 2*pi*rand();

    while in_bounds == true,  
    %Repeat until we are certain a scatter occurs  
      while scattered == false,
      
        valid_voxel = false;
        scattered = false;
        %Do this until we find a new voxel
        while valid_voxel == false,  
        
        ""
        "finding next voxel"
          next_voxel_info = findNextVoxel3(x_pos, y_pos,z_pos, scatter_phi, scatter_theta,xreg,yreg, v_w, v_h,v_d)
        
          x_pos = next_voxel_info(2);
          y_pos = next_voxel_info(3);
          z_pos = next_voxel_info(4);
        
          new_voxel_index = next_voxel_info(1);
        %Once we find a voxel, check if the position is legitimate
          valid_voxel = valid_pos(x_pos, y_pos, z_pos, xrange, yrange,zrange)
        
        %Start the voxel-finding process over if it's not legitimate
          if valid_voxel == false,
          
          %New starting position
          
          %still placeholder values
            x_pos = xrange/2;
            y_pos = yrange/2;
            z_pos = zrange/2;
            scatter_phi = 2*pi*rand();
            scatter_theta = 2*pi*rand();
            in_bounds = false

          endif
       endwhile 

      if and(valid_voxel == true, scattered == false),

        %Check if our photon scatters
        scattered = checkIfScattered(next_voxel_info,positions,r);
        
        
        %Goes to beginnig of loop if there is no scatter
        if scattered == false,
          voxel_found = false;
        endif    
      endif 
    endwhile


      
    if scattered == true,
      "!!!"
      new_voxel_index
      scatter_angle = tetascan_dist2(m,x,phiSteps);
      heatmap(1,new_voxel_index)++;
      scattered = false;
    endif  
   
  endwhile 
  
  endfor
  
  result = heatmap;
  
endfunction
