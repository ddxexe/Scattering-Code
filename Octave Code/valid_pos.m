function result = valid_pos(x_pos, y_pos, z_pos, xrange, yrange,zrange)
  valid = true;

  if or(x_pos < 0, y_pos < 0, z_pos<0, x_pos > xrange, y_pos > yrange, z_pos > zrange),
    valid = false;
  endif

  
    
      
  
result = valid;
endfunction
