function result = find_scatter(angle, xinit, yinit, positions)
dims = size(positions);
dimx = dims(2);
newPosIndex = 1;
xinit
yinit
%Create an array of candidate voxels for collision

if cos(angle) < 0,
  
  %Angle is between pi and 3pi/2 radians
  if sin(angle) < 0,
    %Determine whether to truncate values based on x or y
    for a = 1:dimx,
      if positions(1,a) < xinit && positions(2,a) < yinit,
        
        newPos(1,newPosIndex) = positions(1,a);
        newPos(2,newPosIndex) = positions(2,a);
        newPosIndex += 1;
      endif
    endfor
  endif
  %Angle is between pi/2 and pi radians
  if sin(angle) > 0,
    for b = 1:dimx, 
      if positions(1,b) < xinit && positions(2,b) > yinit,
        
        newPos(1,newPosIndex) = positions(1,b);
        newPos(2,newPosIndex) = positions(2,b);
        newPosIndex += 1;
        
      endif
    endfor
  endif
endif
    
    
if cos(angle) > 0,
  %Between 3pi/2 and 2pi radians
  if sin(angle) < 0,
    for c = 1:dimx,
      if positions(1,c) > xinit && positions(2,c) < yinit,
        
        newPos(1,newPosIndex) = positions(1,c);
        newPos(2,newPosIndex) = positions(2,c);
        newPosIndex += 1;
        newPos;
      endif
    endfor
  endif
  %Between 0 and pi/2 radians 
  
  if sin(angle) > 0,
    
   for d = 1:dimx,
     if positions(1,d) > xinit && positions(2,d) > yinit,

       
        newPos(1,newPosIndex) = positions(1,d);
        newPos(2,newPosIndex) = positions(2,d);
        newPosIndex += 1;
        newPos;
      endif
    endfor
  endif
endif


result = newPos;
endfunction