function result = riemman_y(a, b, n);
  ##PUT FUNCTION HERE##
  
  function y=f(x);
  y=0.5*x - 1;
  endfunction 
  
  dx=(b-a)/n;
  i=[0:n-1];
  
  R=sum(f(a + i*dx) * dx);
  
  for j=(1:n-1), 
    i2(i+1) = f(a+i*dx)*dx;
  endfor
    


result =  i2;

endfunction
