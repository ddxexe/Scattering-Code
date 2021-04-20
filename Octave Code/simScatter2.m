function result=simScatter2(m,x,phiSteps,thetaSteps,xrange,yrange,zrange,xreg,yreg,zreg,r,photons)
  heatmap = zeros(1,xreg*yreg*zreg)
  
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
    scattered = false;
    in_bounds = true;
    x_pos = xrange/2 + 0.5;
    y_pos = yrange/2 + 0.6;
    z_pos = zrange/2 + 0.5;
    scatter_phi = 2*pi*rand();
    scatter_theta = 2*pi*rand();

    %Loops this until we are given a reason to stop the loop   
    while (in_bounds == true),
      
      "beginning of the loop";
        %Finds the next voxel
        
        next_voxel_info = findNextVoxel3(x_pos, y_pos,z_pos,xrange,yrange,zrange, scatter_phi, scatter_theta,xreg,yreg, v_w, v_h,v_d)
           
       %x_pos = next_voxel_info(2);
       %y_pos = next_voxel_info(3);
       %z_pos = next_voxel_info(4);
       %valid_voxel = valid_pos(x_pos, y_pos, z_pos, xrange, yrange,zrange)
     if or(x_pos < 0, x_pos > xrange, y_pos < 0, y_pos > yrange, z_pos < 0, z_pos > zrange),
       a
       in_bounds = false;  
       
     endif
     
     
   endwhile
endfor 

endfunction 
   

  