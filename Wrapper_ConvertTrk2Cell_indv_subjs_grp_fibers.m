%% Converts the whole brain tractography file to cell structure for matlab processing and stores the output in ${dir}/${subj}/Trk_2_Cell/All_fibers

addpaths;
readInputFile;
input_file_other_subjs;

output_dir_tracks_seg = strcat (output_dir_tracks, 'Segmented_tracks_coarse/');

if (exist(output_dir_tracks_seg) == 0)
     mkdir(output_dir_tracks_seg)
end

for i=1:length(trk_list)
    trk_file = strcat(roi_tracks_dir, trk_list{i}, '.trk')
    [header, tracks] = trk_read(trk_file);
    trk_length_vector = trk_length(tracks);
    filtered_tracks_idx = find(trk_length_vector < length_threshold_max & trk_length_vector > length_threshold_min);
    tracks_filtered = tracks(filtered_tracks_idx);
    tracks_new = trk_interp(tracks_filtered, number_of_points_per_track);
    tracks_interp_str = trk_restruc(tracks_new);
    track_cell = ConvertTrk2Cell(tracks_interp_str, Padding, voxDim);
    file_name = strcat(output_dir_tracks_seg, trk_list{i}, '.mat');
    save(file_name, 'track_cell');
    output_string = strcat('Saved track ', trk_list{i});
    disp(output_string);
end
    disp('All trks converted')
