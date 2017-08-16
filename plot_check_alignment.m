figure(); hold on; grid on 
plot3(boundVox(:,1), boundVox(:,2), boundVox(:,3),'.')

num_tracks = length(track_cell_result)
for i = 1:500:num_tracks
    a = track_cell_result{i};
    plot3(a(:,1), a(:,2), a(:,3))
end
