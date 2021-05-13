function result = adj_coord(x,y,z,xs,ys,zs,ang_phi,ang_theta)

%Adjusts the coordinates from a set of global positions and relative angles
%to a set of global positions and angles

%xp,yp,zp are the global position of the photon
%xs,ys,zs are the global poisiton of the scatterer

%ang_phi and ang_theta are angles on a relative system

x0 = sin(ang_theta)*cos(ang_phi);
y0 = sin(ang_theta)*sin(ang_phi);
z0 = cos(ang_theta);

x = x0*cos(ang_theta)*cos(ang_phi) - y0*sin(ang_phi) + z0*sin(ang_theta)*cos(ang_phi);
y = x0*cos(ang_theta)*sin(ang_phi) + y0*cos(ang_phi) + z0*sin(ang_theta)*cos(ang_phi);
z = -x0*sin(ang_theta) + z0*cos(ang_theta);

ang_theta = acos(z);
ang_phi = atan(x/y);

if ang_phi < 0,
    ang_phi = ang_phi + pi;
endif

angle_data_2(1) = ang_phi;
angle_data_2(2) = ang_theta;

result = angle_data_2;
end


