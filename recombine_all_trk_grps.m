addpaths;
readInputFile;
input_file_other_subjs;

subj

rois={'atr_l', 'atr_r', 'cc_frontal', 'cc_occipital', 'cc_parietal', 'cc_temporal', 'cgc_l', 'cgc_r', 'cst_l', 'cst_r','ifo_l', 'ifo_r', 'ilf_l' ,'ilf_r','slf_l'}

output_dirs = strcat(output_dir_tracks, 'Segmented_tracks_coarse/')

%/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/0003107/NewResults/Trk_2_Cell/Segmented_tracks_coarse/

total_num = 0 
for i =1:length(rois)
    output_file_name = strcat(output_dirs, rois{i}, '.mat')
    load(output_file_name)
    num=length(track_cell)
    total_num = total_num + num
end

all_tracks ={}
start_idx = 1
for i = 1:length(rois)
    output_file_name = strcat(output_dirs, rois{i}, '.mat');
    load(output_file_name);
    num_fibers = length(track_cell);
    end_idx = num_fibers+start_idx -1;
    all_tracks(start_idx:end_idx, 1) = track_cell;
    start_idx = end_idx+1;
end

file_name = strcat(output_dirs, 'all_tracks.mat')
save(file_name, 'all_tracks')

