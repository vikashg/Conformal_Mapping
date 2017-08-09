%% Converts the individual .trk files to .mat files (cell structure) and store the output in ${dir}/${subj}/Trk_2_Cell/Segmented_tracks
addpaths;
readInputFile;
input_file_other_subjs;

% trk_list is defined in the input_file_other_subjs;
output_dir_tracks_seg=strcat(output_dir_tracks, '/Segmented_tracks/');

if (exist(output_dir_tracks_seg) == 0)
    mkdir(output_dir_tracks_seg)
end

for i = 1: length(trk_list)

    trk_file=strcat(roi_tracks_dir,trk_list{i}, '.trk')
    [header, tracks] = trk_read(trk_file);

    tracks_new = trk_interp(tracks, number_of_points_per_track); % resampling the track
    tracks_interp_str = trk_restruc(tracks_new);
    disp('Read Track file ');

    track_cell = ConvertTrk2Cell(tracks_interp_str, Padding, voxDim);
    file_name=strcat(output_dir_tracks_seg, trk_list{i}, '.mat')
    save(file_name, 'track_cell');
    output_string = strcat('Saved track ', trk_list{i});
    disp(output_string);
end
    disp('All trks converted');
