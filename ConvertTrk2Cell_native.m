function track_cell_result = ConvertTrk2Cell_native(tracks)

tracks_cell={};
for i=1:1:length(tracks)
    track_i = tracks(i);
    
    % Pad and convert to voxel coordinates
    b=zeros(track_i.nPoints, 3);
    for j =1 : track_i.nPoints
        b(j, :)  = track_i.matrix(j,:);
    end
    tracks_cell{i} = b;
end

track_cell_result = tracks_cell;
end
