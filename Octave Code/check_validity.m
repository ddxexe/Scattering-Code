function result = check_validity(photon_x, photon_y, xrange,yrange)
  viable = 1;
  %Photon moves to the right
  if photon_x < 0 || photon_x > xrange || photon_y < 0 || photon_y > yrange,
    viable = 0;
  endif
result = viable;
endfunction
