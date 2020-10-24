function result = twod_mc(ax, bx, nx, ay, by, ny, trials, d)


##False search variables  
foundx = false;
foundy = false;


#Obtains arraay of area values, 1 row total per dimension
areasx = riemman_x(ax,bx,nx);
areasy = riemman_y(ay,by,ny);

tax = sum(areasx);
tay = sum(areasy);

#Defines dx and dy
dx=(bx-ax)/nx;
dy=(by-ay)/ny;

#2 arrays of indexes
i1=[0:nx-1];
i2 = [0:ny-1];

deltax = ax+(i1+0.5)*dx;
deltay = ay+(i2+0.5)*dy;

#dim random value tables
randsx = rand(trials,d);
randsy = rand(trials,d);


for n1 = 1:nx,
  
  #px and py are the percentile arrays
  px(n1) = sum(areasx(1:n1))/tax;

endfor

for n2 = 1:ny,
  py(n2) = sum(areasy(1:n2))/tay;
endfor


result = tax;
result = tay;

pathsx = zeros(trials, d);
pathsy = zeros(trials, d);
 
for n1 = 1:trials,
  posx = 0;
  posy = 0;
  
  for n2 = 1:d,
    percentilex = randsx(n1,n2);
    percentiley = randsy(n1,n2);
    
    ix=1;
    iy = 1;
    
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
  pathsx(n1,n2) = posx;
  pathsy(n1,n2) = posy;
  foundx = false;
  foundy = false;
  endfor 
    
endfor

for k = 1:trials,
  endpointsx(k) = pathsx(k, d)
  endpointsy(k) = pathsy(k,d)
endfor


average_endx = sum(endpointsx)/trials;
average_endy = sum(endpointsy)/trials;

min(endpointsx)
min(endpointsy)

clf;
scatter(endpointsx,endpointsy,"r")






endfunction
