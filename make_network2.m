function result = make_network2(xrange,xreg,yrange,yreg,zrange,zreg,r)
positions = zeros(2,xreg*yreg);
for a = 1:zreg,
  z_dim = a-1;
  
  for b = 1:yreg,
    y_dim = b-1;
    for c = 1:xreg,
      x_dim = c;
      posIndex = (z_dim * yreg *xreg) + (y_dim * xreg) + x_dim;
      lower_bound_x = (x_dim-1) * (xrange/xreg);
      lower_bound_y = y_dim * (yrange/yreg);
      lower_bound_z = z_dim * (zrange/zreg);
      positions(1,posIndex) =  lower_bound_x + r + (rand() * [(xrange/xreg)- 2*r]);
      positions(2,posIndex) = lower_bound_y + r + (rand() * [(yrange/yreg) - 2*r]);
      positions(3,posIndex) = lower_bound_z + r + (rand() * [(yrange/yreg) - 2*r]);
    
    endfor
  endfor
  endfor
  result = positions ;
endfunction
