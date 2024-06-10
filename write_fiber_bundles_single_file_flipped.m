function  write_fiber_bundles_single_file_flipped(output_dir, roi, tracks)
num_tracks = length(tracks);
number_of_points_per_track = length(tracks{1});


M = zeros(num_tracks*2, number_of_points_per_track*3);
file_name = strcat(output_dir, 'Mapped_fiber_', roi, '.txt')

for i=1:num_tracks
    a = tracks{i};
    b = reshape(a, number_of_points_per_track*3, 1);
    M(i,:) = b;
end
for i=1:num_tracks
    a = tracks{i};
    b = reshape(flip(a), number_of_points_per_track*3, 1);
    M(num_tracks+i,:) = b;
end

random_M= M(randperm(size(M, 1)), :);



dlmwrite(file_name, random_M, 'delimiter', '\t', 'precision', 7)
end
