#Tentative Mie Scattering code

#Uses Mie scattering models and simulations based on the work of Matzler, 2002


%Runs the base code from mie_tetascan
%Maetzler 2002

function result = tetascan_dist(m, x, nsteps)
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

%Sums up approximate area enclosed by 
%mie_tetascan curve

y(1,3) = (pi*(y(1,2).^2)/(2*nsteps));
for k = 1:2*nsteps,
  y(k,4) = y(k,2) * cos(y(k,1));
  y(k,5) = y(k,2) * sin(y(k,1));
  if k > 1,
    y(k,3) =  y(k-1,3) + (pi*(y(k,2).^2)/(2*nsteps));
  end;
endfor;

%Normalizes the values so the area under the curve is 1
norm_dist = 1/y(2*nsteps,3);
for l = 1:2*nsteps,
  z(l,1) = y(l,1);
  z(l,2) = y(l,3) * norm_dist;
end


percentile = rand();
found = false;

while found == false,
  
  for n = 1:2*nsteps,
    
    if percentile > z(n,2) and   (n > 1),
      z(n,1);
      z(n-1,1);
      angle(1,q) = (z(n,1) + z(n+1,1))/2;
    end
  end
end


result=angle;