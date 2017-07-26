%function MapTracks_grpFibers_training_data(data_dir, grp, part_num )

% This is copied from MaptTracks_individualFibers
% Requirements are 
% 1. Main Data Dir
% 2. TracksFileName
% 3. SubjectName
addpaths;
readInputFile; %%%add line to Vikash's directory
input_file_other_subjs;
%trk_list={'atr_l' ,'atr_r' ,'cc_frontal' ,'cc_occipital' ,'cc_parietal', 'cc_pocg' ,'cc_prcg', 'cc_temporal', 'cgc_l', 'cgc_r' , 'cst_l' ,'cst_r' ,'ifo_l' ,'ifo_r', 'ilf_l', 'ilf_r' ,'phc_l', 'phc_r' , 'slf_l' , 'unc_l', 'unc_r'}
%part_num
%roi=trk_list{part_num}
roi
subj
trk_dir= strcat(output_dir_tracks, 'Resampled_augmented_convol/');
trk_cell_file=strcat(trk_dir, roi, '.mat')
output_dir_map = map_tracks_dir %changed output_dir to output_dir_map

%if file doesn't exist exit
if (exist(trk_cell_file) == 0) %it was trk_file
    exit;
end

sample_size=1;
streamlinesFile=strcat(output_dir, 'streamlines.mat');
Mdl_file = strcat(output_dir, 'Models.mat'); %%change is vikash's script

load(streamlinesFile);
load(Mdl_file);
disp('Loaded streamlines and models');

load(trk_cell_file);
disp('Loaded Tracks cell');
%% Map tracks 
if (exist(output_dir_map) == 0)
    mkdir(output_dir_map)
end
combine_tracks_cell=tracks_resampled_cell;
clear filtered_tracks_resampled_cell;

Mapped_tracks=cell(length(combine_tracks_cell),1);

for i=1:sample_size:length(combine_tracks_cell)
%for i=1:sample_size:2
    a=combine_tracks_cell{i};
    for j=1:length(a)
        coordinate=a(j,:);
        [theta_interp, phi_interp] = interpolate_Weighted_matlab(Mdl_ThetaVector, coordinate, thetaVector_unique);
        [pot_interp] = interpolate_pot_Weighted_matlab(Mdl_PotVector, coordinate, NewStreamLines_vector);
        mapped_tracks_i(j,:) = [theta_interp, phi_interp, pot_interp];
    end
    Mapped_tracks{i}=mapped_tracks_i;
i
end


output_file=strcat(output_dir_map, 'Mapped_tracks_', roi , '.mat');
save(output_file, 'Mapped_tracks');
disp (output_file);
