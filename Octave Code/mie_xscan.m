function result = mie_xscan(m, nsteps, dx)
% Computation and plot of Mie Efficiencies for given
% complex refractive-index ratio m=m'+im"
% and range of size parameters x=k0*a,
% starting at x=0 with nsteps increments of dx
% a=sphere radius, using complex Mie coefficients an and bn
% according to Bohren and Huffman (1983) BEWI:TDD122
% result: m', m", x, efficiencies for extinction (qext),
% scattering (qsca), absorption (qabs), backscattering (qb),
% qratio=qb/qsca and asymmetry parameter (asy=<costeta>).
% C. Mätzler, May 2002.
nx=(1:nsteps)';
x=(nx-1)*dx;
for j = 1:nsteps
 a(j,:)=mie(m,x(j));
end;
output_parameters='Real(m), Imag(m), x, Qext, Qsca, Qabs, Qb, <costeta>,
Qb/Qsca'
m1=real(m);m2=imag(m);
plot(a(:,3),a(:,4:9)) % plotting the results
legend('Qext','Qsca','Qabs','Qb','<costeta>','Qb/Qsca')
title(sprintf('Mie Efficiencies, m=%g+%gi',m1,m2))
xlabel('x')
result=a;