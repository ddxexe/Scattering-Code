function result = threed_mc(ax, bx, nx, ay, by, ny, az, bz, nz, trials, d)


##False search variables  
foundx = false;
foundy = false;
foundz = false;


#Obtains arraays of area values, 1 row total per dimension
areasx = riemman_x(ax,bx,nx);
areasy = riemman_y(ay,by,ny);
areasz = riemman_z(ax,bz,nz);

tax = sum(areasx);
tay = sum(areasy);
taz = sum(areasz);

#Defines dx, dy, dz
dx=(bx-ax)/nx;
dy=(by-ay)/ny;
dz=(bz-az)/nz;

#3 arrays of indexes
i1=[0:nx-1];
i2 = [0:ny-1];
i3 = [0:nz-1];

deltax = ax+(i1+0.5)*dx;
deltay = ay+(i2+0.5)*dy;
deltaz = az+(i3+0.5)*dy;


#dim random value tables
randsx = rand(trials,d);
randsy = rand(trials,d);
randsz = rand(trials,d);

for n1 = 1:nx,
  
  #px and py are the percentile arrays
  px(n1) = sum(areasx(1:n1))/tax;

endfor

for n2 = 1:ny,
  py(n2) = sum(areasy(1:n2))/tay;
endfor

for n3 = 1:nz,
  pz(n3) = sum(areasz(1:n3))/taz;
endfor

result = tax;
result = tay;
result = taz;


pathsx = zeros(trials, d);
pathsy = zeros(trials, d);
pathsz = zeros(trials, d);


for n1 = 1:trials,
  posx = 0;
  posy = 0;
  posz = 0;
  
  #Assumes that n1=n2=n3
  
  for n2 = 1:d,
    percentilex = randsx(n1,n2);
    percentiley = randsy(n1,n2);
    percentilez = randsz(n1,n2);
    
    ix=1;
    iy = 1;
    iz = 1;
    
    while foundx == false,
      if percentilex < px(ix),
        delta1 = ax + (ix + 0.5) * dx;
        posx = posx + delta1;
        foundx = true;  
      else,
        ix = ix+1;
      endif
    endwhile
    
    while foundy == false,
      if percentiley < py(iy),
        delta2 = ay + (iy + 0.5) * dy;
        posy = posy + delta2;
        foundy = true;
      else,
        iy = iy + 1;
      endif
    endwhile
    
    while foundz == false,
      if percentilez < pz(iz),
        delta3 = az + (iz + 0.5) * dz;
        posz = posz + delta3;
        foundz = true;
      else,
        iz = iz + 1;
      endif
     endwhile
     
     
  pathsx(n1,n2) = posx;
  pathsy(n1,n2) = posy;
  pathsz(n1,n2) = posz;
  foundx = false;
  foundy = false;
  foundz = false;
  endfor 
    
endfor

for k = 1:trials,
  endpointsx(k) = pathsx(k, d);
  endpointsy(k) = pathsy(k,d);
  endpointsz(k) = pathsz(k,d);
endfor


average_endx = sum(endpointsx)/trials;
average_endy = sum(endpointsy)/trials;
average_endz = sum(endpointsz)/trials;

min(endpointsx)
min(endpointsy)
min(endpointsz)


clf;
scatter3(endpointsx,endpointsy,endpointsz,"r")






endfunction
