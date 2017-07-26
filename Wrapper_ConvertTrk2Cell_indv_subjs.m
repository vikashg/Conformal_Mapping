%% Converts the whole brain tractography file to cell structure for matlab processing and stores the output in ${dir}/${subj}/Trk_2_Cell/All_fibers

addpaths;
readInputFile;
input_file_other_subjs;

%output_dir_traks_af = strcat(output_dir_tracks, 'All_fibers/'); %%CHANGE

output_dir_tracks = strcat(data_dir, 'Trk_2_Cell/All_fibers/');

if (exist(output_dir_tracks) == 0)
     mkdir(output_dir_tracks)
end

%Read tracts
[header, tracks] = trk_read(trk_file_path);
tracks_new = trk_interp(tracks, number_of_points_per_track);
tracks_interp_str = trk_restruc(tracks_new);
disp('Completed reading Tract file');

track_cell = ConvertTrk2Cell(tracks_interp_str, Padding, voxDim);
file_name = strcat(output_dir_tracks, 'All_fibers.mat');
save(file_name, 'track_cell');
disp('All tracts converted');

%% Do the length thresholding 
num_tracks = length(track_cell)
trk_length_vector = zeros(num_tracks, 1); 

for i =1:num_tracks
     track_i = tracks_cell{i};
     trk_size = size(track_i);
     numrows = trk_size(1);
     if (numrows > 1 )
         trk_length_vector(i) = TrackLength(track_i);
     end
end

filtered_tracks_idx = find(trk_length_vector < length_threshold_max & trk_length_vector > length_threshold_min);

tracks_filtered = tracks_cell(filtered_tracks_idx);

%% Divide Tracks now 
DivideTracks(tracks_filtered, num_tracks_per_bundle, output_dir_tracks);

