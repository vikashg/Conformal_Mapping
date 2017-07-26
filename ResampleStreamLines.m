streamlines_uniq_resampled=cell(length(streamlines),1);
for i=1:stepSizeforStreamLines:length(streamlines)
    a=streamlines{i};
    distVec=ones(length(a),1);
    distVec(1)=0;
    for j=1:length(a)-1
      distVec(j+1) = norm(a(j,:)-a(j+1,:));
    end
    
    timePoints1=distVec/sum(distVec);
    timePoints=cumsum(distVec/sum(distVec));

    ts1= timeseries(a, timePoints);
    ts2=resample(ts1, 0.0:0.01:1.0);
    
    a1=ts1.Data;
    b=ts2.Data;
    streamlines_uniq_resampled{i}=b;      
end

