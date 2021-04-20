function result = oned_mc(a, b, n, trials, d)
found = false;
areas = riemman_z(a,b,n);
ta = sum(areas)
dx=(b-a)/n;
i=[0:n-1];
deltas = a+(i+0.5)*dx;
rands = rand(trials,d);

for n1 = 1:n,
  p(n1) = sum(areas(1:n1))/ta;
endfor
p;
result = ta;
paths = zeros(trials, d);

 
for n1 = 1:trials,
  pos = 0;
  for n2 = 1:d,
    percentile = rands(n1,n2);
    i=1;
  
    while found == false,
      
    
      if percentile < p(i),
       
        delta = a+(i+0.5)*dx;
        pos = pos + delta;
        found = true;
        percentile;
        
      else,
        i=i+1;
        
      endif
      
     
    endwhile
  paths(n1,n2) = pos;
  found = false;
  endfor 
    
endfor

for k = 1:trials,
  endpoints(k) = paths(k, d);
endfor
average_end = sum(endpoints)/trials

plot((1:d),paths(1:trials,:))
p
xlabel('Iteration #')
ylabel('Relative position')
endfunction