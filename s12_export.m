function result = s12_export(m,x)
  
angle = 0;
row = 1;
A=zeros(179 , 2 );
while angle < 180  
  column = 1;
  A(row, 1) = angle;
  u = cos(angle);
  scatter = mie_s12(m,x,u);
  A(row, 2) = scatter(3);
  row = row + 1;
  column =  1;
endwhile
  


csvwrite('s12_test.csv', A);


endfunction
