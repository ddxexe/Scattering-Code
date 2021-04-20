
function result = tiny_mc()


t1 = "Tiny Monte Carlo by Scott Prahl (https://omlc.org)";
t2 = "1 W Point Source Heating in Infinite Isotropic Scattering Medium";

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
SHELL_MAX  = 101;

mu_a = double(2);
mu_s = double(20);
microns_per_shell = double(50);
i = double(1000);
shell = 1000;
photons = double(100);


heat =zeros(100);

albedo = mu_s / (mu_s + mu_a)
shells_per_mfp = 1e4/microns_per_shell/(mu_a+mu_s)

for (i = 1:photons),

	x = 0.0; y = 0.0; z = 0.0;					%/*launch*/  
	u = 0.0; v = 0.0; w = 1.0;		
	weight = 1.0;
		
	while true,
		t = -log(rand());	%/*move*/
		x += t * u;
		y += t * v;
		z += t * w;

    
		shell=sqrt(x*x+y*y+z*z)*shells_per_mfp;	%/*absorb*/
    
		if (shell > SHELL_MAX-1),
      shell = SHELL_MAX-1;
    
		  heat(shell) += (1.0-albedo) * weight;
		  weight *= albedo;
		endif
    
		while true,							%/*new direction*/
			xi1=2*(rand() - 0.5); 
			xi2=2*(rand() - 0.5); 
			if ((t=xi1*xi1+xi2*xi2)<=1),
        break;
      endif
		endwhile;
    
		u = 2.0 * t - 1.0;
		v = xi1 * sqrt((1-u*u)/t);
		w = xi2 * sqrt((1-u*u)/t);
			
		if (weight < 0.001), 					%/*roulette*/
	    if (rand() > 0.1), 
        break;
      endif 
			weight =  weight/0.1;
    endif
  endwhile
endfor
  
  

	
printf("%s\n%s\n\nScattering = %8.3f/cm\nAbsorption = %8.3f/cm\n",t1,t2,mu_s,mu_a);
printf("Photons    = %8ld\n\n Radius         Heat\n[microns]     [W/cm^3]\n",photons);
t = 4*3.14159*(microns_per_shell^3)*photons/1e12;
for (i= 1:SHELL_MAX-1),
	printf("%6.0f    %12.5f\n",i*microns_per_shell, heat(i)/t/(i*i+i+1.0/3.0));
  printf(" extra    %12.5f\n",heat(SHELL_MAX-1)/photons);
endfor
result = 0;
endfunction;

