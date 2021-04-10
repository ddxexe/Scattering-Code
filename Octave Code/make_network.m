function result = make_network(xrange,yrange,xreg,yreg,r)



pos = zeros(2,xreg*yreg);
for b = 0:yreg,  
  for a = 1:xreg,
    posIndex = ((b-1) * xreg) + a;
    yceil = ((b-1) * yrange)/yreg;
    xceil = ((a-1) * xrange)/xreg;


    if posIndex > 0 && posIndex <= xreg*yreg,
      
      pos(1, posIndex) = xceil + r + (((xrange/xreg) - 2*r)*rand());
      pos(2, posIndex) = yceil + r + (((yrange/yreg) - 2*r)*rand());
    endif
  endfor
endfor

result = pos;