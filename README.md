The goal of this code is to create a versatile set of robust simulations of Mie network scatters. The utility of the programs is as follows, test change:

# Functions 

**adj_coord.m**

*Description:*
Calculates the new photon position and trajectory. The position and direction are functions of the current photon trajectory, local scattering angles, and step distance.

*Inputs:*
xs, ys, and zs are the global position of the scattering location. This is the first point in our photon's projected path where a scatter within this voxel would be possible. incidence_phi and incidence_theta are the global azimuthal and polar angles of the incident photon's trajectory. sca_phi and sca_theta are the local azimuthal and polar scattering angles. The latter two angles are defined relative to our scattering plane, plane perpendicular to our photon path (characterized by incidence_phi and incidence_theta). dist is the distance per step event in our photon's path. This value is presently defined as one tenth of the diagonal length of each voxel.

*Output:*
next_pos as a 1 x 5 array containing information about the photon's updated position and trajectory. The first 3 columns store the photon's global x, y, and z position coordinates, and the fourth and fifth columns store the photon's global azimuthal and polar angles, phi and theta.

**check_if_scattered.m**

*Description:*
Calculates if the photon is projected to scatter with the scatterer within the same voxel. It identifies whether the particle is projected to scatter at all, as well as how many step events need to happen for a scatter event to take place and the global photon position at the time of the scatter.

*Inputs:*
rp is a 1 x 3 array containing the photon's global rectangular coordinates. ang_phi and ang_theta are the global azimuthal and polar angles for the photon's current direction. rs is a 1 x 3 array containing the scatterer's global rectangular coordinates.

*Outputs:*
Our output is a 1 x 5 array containing information relative to our potential scatter event. Our first element is labelled "result", our second "t", and our third, fourth, and fifth arguments are "x_nearest", "y_nearest", and "z_nearest". 

result is a Boolean which states whether or not a scatter event takes place in this voxel. t is the number of step events which takes place between our current photon's current position and the nearest position needed for a scatter event to take place. x_nearest, y_nearest, and z_nearest are global rectangular coordinates of the photon at the time of the scattering event.



*Output:*
“scattered” is a Boolean which returns a “1” if the distance between the particle and the photon is less than r.

**create_network.m**


*Description:*
Creates a 3-dimensional network of particles. This is done by splitting up a user-defined 3-dimensional space into a series of cubic “voxels”. Each voxel will contain exactly one particle, which will be placed in a random location inside the voxel (the only restriction being that it must be placed so that no part of the particle extends outside the voxel).

*Inputs:*
x_range, y_range, and z_range and the x, y, and z ranges of the 3-dimensional region for the particles to reside within. x_reg, y_reg, and z_reg are the number of divisions of this 3-dimensional space along the x, y, and z axes. This means that the dimensions of a voxel are (x_range/x_reg) by (y_range/y_reg) by (z_range/z_reg). r is the radius of the particle.


*Outputs:*
positions is a 3x(x_reg*y_reg*z_reg) array where each column contains the x, y, and z coordinates of each particle. The first row contains the set of all particle x-coordinates,the second row contains the set of all particle y-coordinates, and the third row contains the set of all particle z-coordinates. 


**find_next_voxel.m**

*Description:* This function takes receives information about the position and direction of a photon and calculates the next voxel a photon will enter. It moves a photon along its projected path, updating its position as it travels. It will detect when it enters a new voxel.

*Inputs:*
x_pos, y_pos, and z_pos are the x, y, and z positions of the photon. x_range, y_range, and z_range, x_reg, y_reg, and z_reg all work the same way as they do in create_network(). Scatter_phi and scatter_theta are the 2 values describing the current angle of the photon’s path. Scatter_phi and scatter_theta follow spherical polar coordinates; or in other words, scatter_phi is the angle on the xy plane relative to the positive x direction, and its measure always lies between 0 and 2*pi. Scatter_theta is the measure of the angle from the positive z direction, and all measures lie between 0 and pi.

*Output:*
photon_info is a 1x7 array containing important information for the photon once it enters a new voxel. The contents of photon_info is as follows:
1.	A value describing which voxel the photon is now inside.
2.	The x position of the photon once it enters a new voxel.
3.	The y position of the photon once it enters a new voxel.
4.	The z position of the photon once it enters a new voxel.
5.	The value of scatter_phi.
6.	The value of scatter_theta.
7.	A Boolean variable determining whether or not the photon is inside or outside the 3-dimensional space.

**mie_tetascan2.m**

*Description:* An updated version or Christian Matzler's intensity function code from 2002. This is the primary function used for characterizing single scatter events and it returns a large number of relevant figures which show information abou the scatter event. This function is largely independent of the other functions stored on the repository.

*Inputs:* m is the refractive index of our scattering media. m can be a complex number of form a+bi, where a is the standard refractive index and b is an attenuation constant. Note that mie_tetascan2 is equipped to account for attenuation but the other functions currently are not designed for this. x is the size parameter, which is a ratio of the incident photon wavelength to the particles' hemisphere circumference. nsteps and n_theta are both parameters used to determine the precision and number of possible scattering angles that will be accounted for. Larger values means the function will tabulate results for a greater number of angles but will consequently require a longer time to compute.

*Outputs:* The function outputs a large set of plots of the single scatter distribution.

The first of these is the intensity distribution function. This is a polar plot showing the intensity as a function of the angle. The angle in this case is the standard polar angle theta, which spans from 0 to 180 degrees. Our plot contains two intensity functions. Our two intensity functions refer to the two types of polarization of light. Each one contains a set of 3 additional plots. The first two of these are the intensity plots for light with parallel and perpendicular polarization (relative to the scattering plane), respectively. The last of these 3 figures is an average of the first two plots.




**sim_scatter.m**

*Description:*
simulates the scattering patterns and distribution of a user-defined number of photons.

*Inputs:*
pos0 is a 1 x 5 array containing the global initial position and path angle of all photons. The first 3 elements of our array contain the global rectangular x, y, and z coordinates while our fourth and fifth elements contain the azimuthal and polar angles phi and theta. scatterer_positions is a user-provided array containing the positions of the particles in our scattering media. The array contains 3 rows (the first row containing the set of all particle x, coordinates, the second row containing the set of all particle y coordinates, and so on) and a column count equal to the number of particles. This should be generated by the make_network function.

x_range, y_range, z_range and r all work the same way as outlined in the other programs. vnx through vnz refer to the number of voxels in the x, y, and z directions. This behaves similarly to x_reg, y_reg, and z_reg in the functions used to create the scatterer particle network. Phi_steps and theta_steps are used to affect the level of precision to calculations. Higher values of phi_steps and theta_steps will yield more accurate simulations, but will take a longer time to execute. The larger the particle network is, the more important it is to use larger values of phi_steps and theta_steps to produce accurate results. nphotons is the number of photons. reflect_prob is the probability that a photon will reflect off the boundaries of our scattering media. stepsize is the distance, in microns, of each step event. Much like phiSteps and thetaSteps, this value will yield more accurate results but will take longer to complete.

*Outputs:*
heatmap is a display of the frequency at which certain voxels have scatters occurring inside them. 

**update_pos.m**

*Description:*
This function updates the photon's global rectangular x, y, and z position.

*Inputs:*
x_pos, y_pos, and z_pos are the global rectangular x, y, and z coordinates. path_phi and path_theta are the global azimuthal and polar angles of the photon velocity. dist is the distance, in microns, that our photon will move per step event.

*Outputs:*
new_pos is a 1 x 5 array. Much like the previous position arrays, the first 3 elements contain information about the position coordinates, and the final 2 elements hane the global azimuthal and polar angles phi and theta.


# Current Shortcomings:
1. Sim_scatter does not re-orient its coordinates as nicely as it potentially could. Many calculations are done along a plane perpendicular to the path of incoming photons and I posit that many measures could be taken to account for this better than I currently have. Efficient computations probably involve plenty of work with vectors and linear algebra in 3D space and as of the time of writing these
ideas have not been properly used in this code.

2. The original build of the code was designed around using HPC and running MATLAB code through a shell instead of a normal GUI. As a result, the code’s output is currently plaintext, which isn’t conducive to many ways of displaying data that one might want to use this code for, such as time-sensitive heatmaps.


3. The code for “check_if_scattered.m”, while functional, is predicated off imprecise methods and has plenty of room for improvement. The current code just runs the distance formula to see how close a photon is to a nearby particle. However, one could possibly rework this function to instead check out if any point in the photon’s projected path has a sufficiently short distance. This is more of a mathematics problem than a coding one. Possible solutions involve checking the difference between projected x/y/z values and their actual values, or by measuring the length of the shortest line segment containing the center of the particle and any point along the photon’s current path. The latter seems to be the most promising approach, and implementing it into the program would likely involve constructing vectors for the photon path and another vector connecting the particle to the end of the first vector. The line that minimizes this distance should be perpendicular to our first vector, meaning its cross-product with the trajectory vector is zero. One could then work their way backwards to find the distance.