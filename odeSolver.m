function [streamlines] = odeSolver(voxData, boundVox,  sizeBoundVox, stepSizeforStreamLines, shapeCenter)
options = odeset('RelTol',1e-3,'AbsTol',[1e-6 1e-6 1e-6]);
streamlines=cell(sizeBoundVox,1);
sphere1 = [shapeCenter(1) shapeCenter(2) shapeCenter(3) 5.0];


for i=1:stepSizeforStreamLines:sizeBoundVox   
    vec = boundVox(i,:);
    tspan=[0 100];
    [t, streamvec] = ode113(@potgrad, tspan, vec, options, voxData, shapeCenter);
 i    
%     streamvec_unique=unique(streamvec, 'rows');
%     shapeCenter_rows=repmat(shapeCenter, length(streamvec_unique), 1);
%     
%     distVec=euclidean(streamvec_unique', shapeCenter_rows');
%     
%     distVec_diag= diag(distVec)
%    
%     idx=find(distVec_diag > 5.0);
%     distVec_diag(idx(length(idx)))
%     a_start=streamvec_unique(idx(length(idx)),:);
%     a_end=streamvec_unique((length(idx)+1),:);
%     dx=a_start(1)-a_end(1);
%     dy=a_start(2) - a_end(2);
%     dz = a_start(3) - a_end(3);
%     line=[a_start(1) a_start(2) a_start(3) dx dy dz];
%     endPoint=intersectLineSphere(line, sphere1);
%     streamvec_unique(length(idx)+1,:)=endPoint(1,:);

%    plot3(streamvec(:,1), streamvec(:,2), streamvec(:,3)); 
%    hold on; grid on;
%     distVec_diag((length(idx)+1))
%     streamVec(length(idx)+2:end,:)=[]
    
    
    
%     x0=streamvec(end-1,1);
%     y0=streamvec(end-1,2);
%     z0=streamvec(end-1,3);
%     
%     differ=streamvec(end,:)-streamvec(end-1,:);
%     dx=differ(1); dy=differ(2); dz = differ(3);
%     line=[x0 y0 z0 dx dy dz];
%     pts=intersectLineSphere(line, sphere);
%     streamvec(end,:)=[pts(1) pts(2) pts(3)];
    streamlines{i} = streamvec;
%     unique(streamvec , 'rows')
%     pause
end
