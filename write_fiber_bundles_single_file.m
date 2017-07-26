function  write_fiber_bundles(output_dir, roi, tracks)
num_tracks = length(tracks);
number_of_points_per_track = length(tracks{1});


M = zeros(num_tracks, number_of_points_per_track*3);
file_name = strcat(output_dir, 'Mapped_fiber_', roi, '.txt')

for i=1:num_tracks
    a = tracks{i};
    b = reshape(a, number_of_points_per_track*3, 1);
    M(i,:) = b;
end

dlmwrite(file_name, M, 'delimiter', '\t', 'precision', 7)
end
