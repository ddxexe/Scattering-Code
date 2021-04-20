function result = check_if_scattered(photon_x,photon_y,photon_z,part_x,part_y,part_z,r)

%Checks the current position of the photon and its projected path
%Determines if the photon will get sufficiently close to the particle

scattered = false;

dist = sqrt((photon_x-part_x)^2+(photon_y-part_y)^2+(photon_z-part_z)^2);

if dist<r
    scattered = true;
end

result = scattered;

end