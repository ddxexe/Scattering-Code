function result = update_pos(x_pos,y_pos,z_pos,path_phi,path_theta,vx,vy,vz)


%We define the distance of our step event as
dist = 0.1 * sqrt((vx)^2+(vy)^2+(vz)^2);

x_pos += dist * (cos(path_phi)*sin(path_theta));
y_pos += dist * (sin(path_theta)*sin(path_phi));
z_pos += dist * (cos(path_theta));

new_pos = [x_pos,y_pos,z_pos,path_phi,path_theta];

result = new_pos;
endfunction