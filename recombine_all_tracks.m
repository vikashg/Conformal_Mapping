addpaths;
readInputFile;
input_file_other_subjs;

subj

output_dir_tracks_all = strcat(output_dir_tracks, '/All_fibers/'); %final output for one mat file
streamlines = strcat(output_dir, '/streamlines.mat');

%num_tracks = length(track_cell);

count_file = 0; %counts how many .mat files exist
load(streamlines);

for i=1:40
    output_file_name = strcat(output_dir_tracks_all, 'Tracks_', num2str(i), '.mat');
    if (exist(output_file_name))
      count_file = count_file + 1;
    end
end

num_tracks_all = count_file * num_tracks_per_bundle;
track_cell = {}; %zeros(num_tracks_all, 1);

start_idx=1;

for i=1:count_file;
    output_file_name = strcat(output_dir_tracks_all, 'Tracks_', num2str(i), '.mat');
    load(output_file_name, 'tracks_resampled_cell');
    %num_tracks = length(tracks_resampled_cell)
    %count_trk = count_trk + num_tracks
    %for j=1:num_tracks
    end_idx = start_idx - 1 + length(tracks_resampled_cell);
    % trk_length_vector{j,1} = tracks_resampled_cell{j,1};
    track_cell(start_idx : end_idx, 1) = tracks_resampled_cell;
    start_idx = end_idx + 1;
       % a = tracks_resampled_cell{j,1}
       % trk_length_vector{j,1} = num2cell(a) %((:,1), a(:,2), a(:,3))
  %  end
end

file_name = strcat(output_dir_tracks_all, '/recombined_all_tracks.mat');
save(file_name, 'track_cell');        
disp(strcat ('Number of tracks in file ', num2str(count_file)));        