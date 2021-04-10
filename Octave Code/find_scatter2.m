function result = find_scatter2(angle, xinit, yinit, xrange, yrange,xreg,yreg, positions, r)

%finds the correct scatterer along a photon's path

found = 0;
photon_x = xinit;
photon_y = yinit;
d = 2 * r * asin(0.01);
valid = 1
while found == 0 && valid == 1,
  
  %Updates the x,y position of photon
  photon_x += d * cos(angle);
  photon_y += d * sin(angle);
  
  %Finds the voxel containing the photon
  voxel_x = ceil(photon_x/(xrange/xreg)) ;
  voxel_y = ceil(photon_y/(yrange/yreg));
 
  voxel_i = voxel_y * xreg + voxel_x;
  voxel_i
  voxel_up = voxel_i + xreg;
  voxel_down = voxel_i - xreg;
  voxel_left = voxel_i - 1;
  voxel_right = voxel_i + 1;
  valid = check_validity(photon_x,photon_y,xrange,yrange);
  if voxel_up < xreg*yreg,  
    voxel_up;
    %"Up"
    found=check_dist(photon_x,photon_y,positions(:,voxel_up),r);
  endif
  if voxel_down > 0,
    %"Down"
    found = check_dist(photon_x, photon_y, positions(:,voxel_down), r );
  endif
  if mod(voxel_left,xreg) > 0,
    %"Left"
    found = check_dist(photon_x, photon_y, positions(:,voxel_left), r );
  endif
  if mod(voxel_right, xreg) != 1 ,
    %"Right"
    found = check_dist(photon_x, photon_y, positions(:,voxel_right), r );
  endif
  
endwhile


result = found;