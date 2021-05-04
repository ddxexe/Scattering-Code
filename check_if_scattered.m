function result = check_dist(xp, yp, zp, ang_phi, ang_theta, xs, ys, zs, r)
found = false;
%x0 through z0 are the photon rectangular coordinates
%x1 through z1 are the particle rectangular coordinates
%ang_phi, ang_theta work as they normally would in spherical coordinates

xd = xp-xs;
yd = yp-ys;
zd = zp-zs;

xa = cos(ang_phi)*sin(ang_theta);
ya = sin(ang_phi)*sin(ang_theta);
za = cos(ang_theta);

t = -(xd*xa + yd*ya + zd*za);

x_dist = xd + t * xa;
y_dist = yd + t * ya;
z_dist = zd + t * za;

dist = sqrt(x_dist^2 + y_dist^2 + z_dist^2);

if dist < r,
  found  = true;
endif
result = found;

endfunction 