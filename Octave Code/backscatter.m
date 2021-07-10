function result = backscatter(x_pos,y_pos,z_pos,x_range,y_range,z_range,scatter_phi,scatter_theta)
  %Backscatters photon
  %Reverses whichever velocity coordinate (x,y,z) is causing 
  %the photon to exit the bounds of the system
  %Returns 1x5 array with new backscattered positions and velocity
  
  
  %obtains x,y,z coordinates for photon velocity
  x_comp = sin(scatter_phi)*cos(scatter_theta);
  y_comp = sin(scatter_phi)*sin(scatter_theta);
  z_comp = cos(scatter_theta);
  
  
  %reverses coordinates
  if or(x_pos < 0, y_pos < 0, z_pos < 0),
    
    if x_pos < 0,
      x_comp *= -1;
    endif
    
    if y_pos < 0
      y_comp *= -1;
    endif
    
    if z_pos < 0,
      z_comp *= -1;
    endif
    
   endif

   if or(x_pos > x_range, y_pos > y_range, z_pos > z_range),
  
      if x_pos > x_range,
        x_comp *= -1;
      endif
      
      if y_pos > y_range,
        y_comp *= -1;
      endif
      
      
      if z_pos > z_range,
        z_comp *= -1;
      endif
      
    endif 
    
    %Finds new theta/phi based on update x,y,z_coords
    scatter_theta = acos(z_comp);
    scatter_phi = atan(x_comp/y_comp);
    if scatter_phi < 0,
      scatter_phi += pi;
    endif
    
    
    %Generates position and velocity array
    backscatter_coords(1) = x_pos + x_comp;
    backscatter_coords(2) = y_pos + y_comp;
    backscatter_coords(3) = z_pos + z_comp;
    backscatter_coords(4) = scatter_phi;
    backscatter_coords(5) = scatter_theta;
    
    result = backscatter_coords;
endfunction
