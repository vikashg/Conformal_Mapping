%function MapTracks_grpFibers_training_data(data_dir, grp, part_num )

% This is copied from MaptTracks_individualFibers
% Requirements are 
% 1. Main Data Dir
% 2. TracksFileName
% 3. SubjectName
addpaths;
readInputFile; %add to vikash's script
input_file_other_subjs;
d %changed k to d
trk_dir= strcat(output_dir_tracks, 'All_fibers/');
trk_cell_file=strcat(trk_dir, 'Tracks_', num2str(d) , '.mat');%changed k to d
output_dir_map=map_tracks_dir %cahnged output_dir to output_dir_map

sample_size=1;
streamlinesFile=strcat(output_dir, 'streamlines.mat'); %%change in Vikash's script
Mdl_file = strcat(output_dir, 'Models.mat');

%streamlinesFile=strcat(data_dir, 'Vol_Param_check_1/streamlines.mat');
%Mdl_file = strcat(data_dir, 'Vol_Param_check_1/Models.mat');

load(streamlinesFile);
load(Mdl_file);
disp('Loaded streamlines');


load(trk_cell_file);
disp('Loaded Tracks cell');
%% Map tracks 
% output_dir_map=strcat(data_dir, 'Mapped_tracks') %cahnged output_dir to output_dir_map
if (exist(output_dir_map) == 0)
    mkdir(output_dir_map)
end
combine_tracks_cell=tracks_resampled_cell;
clear filtered_tracks_resampled_cell;

Mapped_tracks=cell(length(combine_tracks_cell),1);

for i=1:sample_size:length(combine_tracks_cell)
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

output_file=strcat(output_dir_map, 'Mapped_tracks_', num2str(d) , '.mat'); %changed k to d
save(output_file, 'Mapped_tracks');
disp (output_file);
