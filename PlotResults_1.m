figure()
hold on; grid off
for i=1:50:length(streamlines_uniq)
    a = streamlines_uniq{i};
    plot3(a(:, 1), a(:, 2), a(:, 3))
end



plot3(boundVox(1:5:length(boundVox),1), boundVox(1:5:length(boundVox), 2), boundVox(1:5:length(boundVox), 3), '.')

plot3(endPoints_strLines(:, 1), endPoints_strLines(:, 2), endPoints_strLines(:, 3), 'g.')

for i =1:1:length(track_cell)
    a = track_cell{i};
    plot3(a(:,1), a(:, 2), a(:, 3))
end