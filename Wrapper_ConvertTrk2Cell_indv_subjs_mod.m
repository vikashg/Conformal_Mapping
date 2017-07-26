%% Converts the whole brain tractography file to cell structure for matlab processing and stores the output in ${dir}/${subj}/Trk_2_Cell/All_fibers

addpaths;
readInputFile;
input_file_other_subjs;

output_dir_tracks_all = strcat (output_dir_tracks, '/All_fibers/');
%output_dir_tracks = strcat(data_dir, 'Trk_2_Cell/All_fibers/');

if (exist(output_dir_tracks_all) == 0)
     mkdir(output_dir_tracks_all)
end
%if (exist(output_dir_tracks) == 0)
%     mkdir(output_dir_tracks)
%end

%Read tracts
[header, tracks] = trk_read(trk_file_path);
trk_length_vector = trk_length(tracks);
filtered_tracks_idx = find(trk_length_vector < length_threshold_max & trk_length_vector > length_threshold_min);

tracks_filtered = tracks(filtered_tracks_idx);

DivideTracks_trk_format(tracks_filtered, num_tracks_per_bundle, number_of_points_per_track, Padding, voxDim, output_dir_tracks_all);
%DivideTracks_trk_format(tracks_filtered, num_tracks_per_bundle, number_of_points_per_track, Padding, voxDim, output_dir_tracks);
