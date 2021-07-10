function result = reflect_comps(x_pos,y_pos,z_pos,x_range,y_range,z_range,path_phi,path_theta)
  path_angles = zeros(1,2);
  %If out of bounds, reflect the x, y, and/or z components needed
  x_comp = cos(path_phi)*sin(path_theta);
  y_comp = sin(path_phi)*sin(path_theta);
  z_comp = cos(path_theta);

  if or(x_pos < 0, x_pos >= x_range),
    x_comp *= -1;
  endif
  if or(y_pos < 0, y_pos >= y_range),
    y_comp *= -1;
  endif
  if or(z_pos < 0, z_pos >= z_range),
    z_comp *= -1;
  endif

  %generate new angles
  path_phi = atan(y_comp/x_comp);
  if path_phi < 0,
    path_phi = path_phi + pi;
  endif      
  path_theta = acos(z_comp);

  path_angles(1,1) = path_phi;
  path_angles(1,2) = path_theta;
  result = path_angles;
endfunction