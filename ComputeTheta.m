function thetaVector = ComputeTheta(streamLines, stepSizeforStreamLines, shapeCenter)

Size_streamLines = length(streamLines);
Vec_stream_endpoint=ones(Size_streamLines, 3);
for i =1:stepSizeforStreamLines:Size_streamLines
    streamline = streamLines{i};
    streamLine_endpoint = streamline(length(streamline),:);
    Vec_stream_endpoint(i,:)=streamLine_endpoint-shapeCenter;
end


[theta, phi, r] = cart2sph(Vec_stream_endpoint(:,1), Vec_stream_endpoint(:,2), Vec_stream_endpoint(:,3));

% Azimuthal == theta
% Elevation == Phi;

%% Put the theta value along the streamLines 
 X=[]; Y=[]; Z=[];theta_V=[]; phi_V=[];
 for i=1:stepSizeforStreamLines:length(streamLines)
     X=[X;streamLines{i}(:,1)];
     Y=[Y;streamLines{i}(:,2)];
     Z=[Z;streamLines{i}(:,3)];
     theta_V_temp=ones(length(streamLines{i}),1)*theta(i);
     phi_V_temp=ones(length(streamLines{i}),1)*phi(i);
     theta_V=[theta_V; theta_V_temp];
     phi_V=[phi_V; phi_V_temp];
     tmp=length(streamLines{i});
   
 end 
 thetaVector=[X, Y, Z, theta_V, phi_V];

