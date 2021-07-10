function result=sim_scatter_heatmap(scatterer_positions,m,x,phiSteps,thetaSteps, x_range,y_range,z_range,x_reg,y_reg,z_reg,r,photons,backscatter_prob)
  photons
  heatmap = zeros(photons,5);
  
  %vx,vy, and vz are the relative indexes along the x,y, and z axes
  vx = x_range/x_reg;
  vy = y_range/y_reg;
  vz = z_range/z_reg;
  
  %Create network of scattering media particles
  
  %First step event
  for i = 1:photons,
    heatmap(i,1) = x_range*0.51;
    heatmap(i,2) = y_range*0.51;
    heatmap(i,3) = z_range*0.51;
    path_phi = 0;
    path_theta = pi/2;
    step_pos = update_pos(heatmap(i,1),heatmap(i,2),heatmap(i,3),path_phi,path_theta,vx,vy,vz);
    
    heatmap(i,1) = step_pos(1);
    heatmap(i,2) = step_pos(2);
    heatmap(i,3) = step_pos(3);
    heatmap(i,4) = step_pos(4);
    heatmap(i,5) = step_pos(5);
  endfor
  csvwrite("step1_dist.csv",heatmap);
  
  
  step = 2;
  %Loop until we run out of photons
  while size(heatmap,1)!=0,

  %Remove all photons which leave the media from our heatmap data
    j=1;
    while j <= size(heatmap,1),
      in_bounds = bound_check(heatmap(j,1),heatmap(j,2),heatmap(j,3),x_range,y_range,z_range,path_phi,path_theta,backscatter_prob);
     
      if in_bounds == true,
        j++;
      elseif rand > backscatter_prob,
        heatmap(j,:)=[];
      elseif,
        bounded_pos = bound_pos_update(heatmap(j,1),heatmap(j,2),heatmap(j,3),x_range,y_range,z_range);
        heatmap(j,1) = bounded_pos(1);
        heatmap(j,2) = bounded_pos(2);
        heatmap(j,3) = bounded_pos(3);
        path_angles = reflect_comps(heatmap(j,1),heatmap(j,2),heatmap(j,3),x_range,y_range,z_range,path_phi,path_theta);
        path_phi = path_angles(1);
        path_theta = path_angles(2);
      endif  
    endwhile


    k = 1;
    while k <= size(heatmap,1),
      path_phi = heatmap(k,4);
      path_theta = heatmap(k,5);
      %Check if the particle will scatter with the nearest scatterer
      scattered =  check_if_scattered_local(heatmap(k,1),heatmap(k,2),heatmap(k,3),x_range,y_range,z_range,vx,vy,vz,scatterer_positions,r);
      if scattered,
 
        %If a scatter occurs, change the angle and adjust the coordinates appropriately

        path_phi = tetascan_dist2(m,x,phiSteps);

        path_theta = rand*pi;
        heatmap(k,4) = path_phi;
        heatmap(k,5) = path_theta; 
        

        step_pos = adj_coord(heatmap(k,1),heatmap(k,2),heatmap(k,3),path_phi,path_theta);
      %Otherwise, continue to have the photon travel along its path
      else,
        step_pos = update_pos(heatmap(k,1),heatmap(k,2),heatmap(k,3),path_phi,path_theta,vx,vy,vz);
      endif
      heatmap(k,1) = step_pos(1);
      heatmap(k,2) = step_pos(2);
      heatmap(k,3) = step_pos(3);
      
      k++

    endwhile
    csv_name = strcat("step",num2str(step),"_dist.csv");
    
    csvwrite(csv_name,heatmap);
    step++;
    step

heatmap;
endwhile

result = heatmap;
endfunction