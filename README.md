The goal of this code is to create a versatile set of robust simulations of Mie network scatters. The utility of the programs is as follows:

# Functions 

**adj_coord.m**

*Description:* Calculates the new photon position and trajectory. The position and direction are functions of the current photon trajectory, local scattering angles, and step distance.

*Inputs:*
xs, ys, and zs are the global position of the scattering location. This is the first point in our photon's projected path where a scatter within this voxel would be possible. incidence_phi and incidence_theta are the global azimuthal and polar angles of the incident photon's trajectory. sca_phi and sca_theta are the local azimuthal and polar scattering angles. The latter two angles are defined relative to our scattering plane, plane perpendicular to our photon path (characterized by incidence_phi and incidence_theta). dist is the distance per step event in our photon's path. This value is presently defined as one tenth of the diagonal length of each voxel.

*Output:*
next_pos is a 1 x 5 array containing information about the photon's updated position and trajectory. The first 3 columns store the photon's global x, y, and z position coordinates, and the fourth and fifth columns store the photon's global azimuthal and polar angles, phi and theta.

**bound_check.m**
*Description:* This program returns a "true" or "false" value. It is assumed to be "true" unless one or more of the x,y, or z coordinates exceeds  or goes below certain values which are defined by the user at the initialization.

*Inputs:* x_pos, y_pos, and z_pos are the position of the photon in rectangular coordinates. x_range, y_range, and z_range are the sizes of our region hosting our scattering media along the x, y, z directions.

*Outputs:* in_bounds assumes either a value of "true" or "false", depending on whether or not the photon lies within our scattering media region.



**make_network.m**


*Description:*
Creates a 3-dimensional network of particles. This is done by splitting up a user-defined 3-dimensional space into a series of cubic “voxels”. Each voxel will contain exactly one particle, which will be placed in a random location inside the voxel (the only restriction being that it must be placed so that no part of the particle extends outside the voxel).

*Inputs:*
x_range, y_range, and z_range and the x, y, and z ranges of the 3-dimensional region for the particles to reside within. x_reg, y_reg, and z_reg are the number of divisions of this 3-dimensional space along the x, y, and z axes. This means that the dimensions of a voxel are (x_range/x_reg) by (y_range/y_reg) by (z_range/z_reg). r is the radius of the particle.


*Outputs:*
positions is a 3x(x_reg*y_reg*z_reg) array where each column contains the x, y, and z coordinates of each particle. The first row contains the set of all particle x-coordinates,the second row contains the set of all particle y-coordinates, and the third row contains the set of all particle z-coordinates. 





**reflect_comps.m**
*Description:* This is the main function. It can calculate a variety of figures which characterize the scattering events and photon propagation.

*Inputs:* x_pos, y_pos, and z_pos are the position of the photon in rectangular coordinates. x_range, y_range, and z_range are the sizes of our region hosting our scattering media along the x, y, z directions. path_phi and path_theta are the global azimuthal and polar angles of the photon velocity.

*Outputs:* The output is an array containing 5 elements. The first 3 elements are the rectangular x, y, and z position coordinates. The fourth and fifth elements are the global azimuthal and polar angles for the photon's direction.

**sim_scatter.m**

*Description:* simulates the scattering patterns and distribution of a user-defined number of photons.

*Inputs:* pos0 is a 1 x 5 array containing the global initial position and path angle of all photons. The first 3 elements of our array contain the global rectangular x, y, and z coordinates while our fourth and fifth elements contain the azimuthal and polar angles phi and theta. scatterer_positions is a user-provided array containing the positions of the particles in our scattering media. The array contains 3 rows (the first row containing the set of all particle x, coordinates, the second row containing the set of all particle y coordinates, and so on) and a column count equal to the number of particles. This should be generated by the make_network function.

x_range, y_range, z_range and r all work the same way as outlined in the other programs. vnx through vnz refer to the number of voxels in the x, y, and z directions. This behaves similarly to x_reg, y_reg, and z_reg in the functions used to create the scatterer particle network. Phi_steps and theta_steps are used to affect the level of precision to calculations. Higher values of phi_steps and theta_steps will yield more accurate simulations, but will take a longer time to execute. The larger the particle network is, the more important it is to use larger values of phi_steps and theta_steps to produce accurate results. nphotons is the number of photons. reflect_prob is the probability that a photon will reflect off the boundaries of our scattering media. stepsize is the distance, in microns, of each step event. Much like phiSteps and thetaSteps, this value will yield more accurate results but will take longer to complete.

*Outputs:*
heatmap is a display of the frequency at which certain voxels have scatters occurring inside them. 


**tetascan_dist2.m**

*Description:* An updated version or Christian Matzler's intensity function code from 2002. This is the primary function used for characterizing single scatter events and it returns a large number of relevant figures which show information abou the scatter event. This function is largely independent of the other functions stored on the repository.

*Inputs:* m is the refractive index of our scattering media. m can be a complex number of form a+bi, where a is the standard refractive index and b is an attenuation constant. Note that mie_tetascan2 is equipped to account for attenuation but the other functions currently are not designed for this. x is the size parameter, which is a ratio of the incident photon wavelength to the particles' hemisphere circumference. nsteps and n_theta are both parameters used to determine the precision and number of possible scattering angles that will be accounted for. Larger values means the function will tabulate results for a greater number of angles but will consequently require a longer time to compute.

*Outputs:* angle is a single value denoting the scattering angle, relative to the scattering plane.

**update_pos.m**

*Description:* This function updates the photon's global rectangular x, y, and z position.

*Inputs:* x_pos, y_pos, and z_pos are the global rectangular x, y, and z coordinates. path_phi and path_theta are the global azimuthal and polar angles of the photon velocity. dist is the distance, in microns, that our photon will move per step event.

*Outputs:* new_pos is a 1 x 5 array. Much like the previous position arrays, the first 3 elements contain information about the position coordinates, and the final 2 elements hane the global azimuthal and polar angles phi and theta.

**voxel_check.m**

*Description:* Returns the index of the voxel containing a specific (x,y,z) position coordinate.

*Inputs:* scatterer_positions is an array containing the positions of every scatterer particle. r is the radius of each particle. vdx, vdy, and vdz are the lengths of the x, y, and z components of each voxel. vnx, vny, and vnz are the number of voxels in the x, y, and z directions.

*Outputs:* The output is a column array containing 3 elements.

# Current Shortcomings:


1. The original build of the code was designed around using HPC and running MATLAB code through a shell instead of a normal GUI. As a result, the code’s output is currently plaintext, which isn’t conducive to many ways of displaying data that one might want to use this code for, such as time-sensitive heatmaps.

