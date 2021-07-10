function result = bound_check(x_pos,y_pos,z_pos,x_range,y_range,z_range,path_phi,path_theta,backscatter_prob)
  in_bounds = true;
  
  
  
    %If backscatter doesnt't happen and photon is out-of-bounds,
    if or(x_pos < 0, y_pos < 0, z_pos < 0),
      in_bounds = false;
    endif
    if or(x_pos >= x_range, y_pos >= y_range, z_pos  >= z_range),
      in_bounds = false; 
    endif
    

    
 

  result = in_bounds;
endfunction
