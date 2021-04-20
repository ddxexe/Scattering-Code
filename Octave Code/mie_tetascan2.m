function result = mie_tetascan2(m, x, nsteps, n_theta)
% Computation and plot of Mie Power Scattering function for given
% complex refractive-index ratio m=m'+im", size parameters x=k0*a,
% according to Bohren and Huffman (1983) BEWI:TDD122
% C. Mätzler, May 2002.
nsteps=nsteps;
m1=real(m); m2=imag(m);
nx=(1:nsteps); dteta=pi/(nsteps-1);
teta=(nx-1).*dteta;
 for j = 1:nsteps,
 u=cos(teta(j));
 a(:,j)=mie_s12(m,x,u);
 SL(j)= real(a(1,j)'*a(1,j));
 SR(j)= real(a(2,j)'*a(2,j));
end;


y=[teta teta+pi;SL SR(nsteps:-1:1)]';
for(y2=1:n_theta), %y increments the array y
  for (z2 = 1:nsteps), %z increments the 0 to 180 portion
    s_array((y2*nsteps)+z2, 1)=y(y2+1,1);
    s_array((y2*nsteps) + z2, 2) =y(y2+1,2);
    s_array((y2*nsteps) + z2, 3) = z2 * (180/n_theta);
  endfor;
endfor;

s_array
polar(y(:,1),y(:,2))
title(sprintf('Mie angular scattering: m=%g+%gi, x=%g',m1,m2,x));
xlabel('Scattering Angle')
result=y;

endfunction