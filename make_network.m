function result = make_network(x_range,x_reg,y_range,y_reg,z_range,z_reg,r)


%Creates an array of voxels and a random arrangement of particles
%Each voxel has exactly one particle placed in a random location
%x/y/z_range are the size of the x/y/z regions 
%x/y/z_reg are the number of divisions in the x/y/z axes

positions=zeros(3,x_reg*y_reg*z_reg); %you may be able to remove this line of code entirely 

for a = 1:z_reg
    for b = 1:y_reg
        for c = 1:x_reg
            posIndex = ((a-1)*y_reg*x_reg)+((b-1)*x_reg)+c;
            lower_bound_x =(c-1)*(x_range/x_reg);
            lower_bound_y = (b-1)*(y_range/y_reg);
            lower_bound_z = (a-1)*(z_range/z_reg);

            positions(1,posIndex) = lower_bound_x+r+(rand*((x_range/x_reg)-2*r));
            positions(2,posIndex) = lower_bound_y+r+(rand*((y_range/y_reg)-2*r));
            positions(3,posIndex) = lower_bound_z+r+(rand*((z_range/z_reg)-2*r));
        end
    end
end
result = positions;

end

