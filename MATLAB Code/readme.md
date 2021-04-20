The goal of this code is to create a versatile set of robust simulations of Mie network scatters. The utility of the programs is as follows:

#check_if_scattered.m

##Description: A very basic 3D distance calculation between a photon and a particle. It could be removed and readily incorporated into other functions but it is currently kept as a separate program because there is still plenty of room for improvement; see the last section of this file for more.

*#Inputs: photon_x, photon_y, photon_z are the x, y, and z coordinates of our photon. part_x, part_y, and part_z are the x, y, and z coordinates of the particle. r is the radius of the particle.

##Output: “scattered” is a Boolean which returns a “1” if the distance between the particle and the photon is less than r.

#create_network.m


##Description:

###Creates a 3-dimensional network of particles. This is done by splitting up a user-defined 3-dimensional space into a series of cubic “voxels”. Each voxel will contain exactly one particle, which will be placed in a random location inside the voxel (the only restriction being that it must be placed so that no part of the particle extends outside the voxel).

##Inputs:

###x_range, y_range, and z_range and the x, y, and z ranges of the 3-dimensional region for the particles to reside within. x_reg, y_reg, and z_reg are the number of divisions of this 3-dimensional space along the x, y, and z axes. This means that the dimensions of a voxel are (x_range/x_reg) by (y_range/y_reg) by (z_range/z_reg). r is the radius of the particle.


##Outputs: 

###positions is a 3x(x_reg*y_reg*z_reg) array where each column contains the x, y, and z coordinates of each particle. The first row contains the set of all particle x-coordinates,the second row contains the set of all particle y-coordinates, and the third row contains the set of all particle z-coordinates. 


#find_next_voxel.m

##Description: This function takes receives information about the position and direction of a photon and calculates the next voxel a photon will enter. It moves a photon along its projected path, updating its position as it travels. It will detect when it enters a new voxel.


##Inputs:

###x_pos, y_pos, and z_pos are the x, y, and z positions of the photon. x_range, y_range, and z_range, x_reg, y_reg, and z_reg all work the same way as they do in create_network(). Scatter_phi and scatter_theta are the 2 values describing the current angle of the photon’s path. Scatter_phi and scatter_theta follow spherical polar coordinates; or in other words, scatter_phi is the angle on the xy plane relative to the positive x direction, and its measure always lies between 0 and 2*pi. Scatter_theta is the measure of the angle from the positive z direction, and all measures lie between 0 and pi.


##Output:

###photon_info is a 1x7 array containing important information for the photon once it enters a new voxel. The contents of photon_info is as follows:

1.	A value describing which voxel the photon is now inside.
2.	The x position of the photon once it enters a new voxel.
3.	The y position of the photon once it enters a new voxel.
4.	The z position of the photon once it enters a new voxel.
5.	The value of scatter_phi.
6.	The value of scatter_theta.
7.	A Boolean variable determining whether or not the photon is inside or outside the 3-dimensional space.



#sim_scatter.m

##Description: simulates the scattering patterns and distribution of a user-defined number of photons.

##Inputs:
###x_range, y_range, z_range, x_reg, y_reg, z_reg, and r all work the same way as outlined in the other programs. Phi_steps and theta_steps are used to affect the level of precision to calculations. Higher values of phi_steps and theta_steps will yieldmore accurate simulations, but will take a longer time to execute. The larger the particle network is, the more important it is to use larger values of phi_steps and theta_steps to produce accurate results.“photons” is the number of photons that will be simulated.

##Outputs:

###heatmap is a display of the frequency at which certain voxels have scatters occurring inside them. 

#Current Shortcomings:
1. Sim_scatter does not re-orient its coordinates as nicely as it potentially could. Many calculations are done along a plane perpendicular to the path of incoming photons and I posit that many measures could be taken to account for this better than I currently have. Efficient computations probably involve plenty of work with vectors and linear algebra in 3D space and as of the time of writing these
ideas have not been properly used in this code.

2. The original build of the code was designed around using HPC and running MATLAB code through a shell instead of a normal GUI. As a result, the code’s output is currently plaintext, which isn’t conducive to many ways of displaying data that one might want to use this code for, such as time-sensitive heatmaps.


3. The code for “check_if_scattered.m”, while functional, is predicated off imprecise methods and has plenty of room for improvement. The current code just runs the distance formula to see how close a photon is to a nearby particle. However, one could possibly rework this function to instead check out if any point in the photon’s projected path has a sufficiently short distance. This is more of a mathematics problem than a coding one. Possible solutions involve checking the difference between projected x/y/z values and their actual values, or by measuring the length of the shortest line segment containing the center of the particle and any point along the photon’s current path. The latter seems to be the most promising approach, and implementing it into the program would likely involve constructing vectors for the photon path and another vector connecting the particle to the end of the first vector. The line that minimizes this distance should be perpendicular to our first vector, meaning its cross-product with the trajectory vector is zero. One could then work their way backwards to find the distance.
