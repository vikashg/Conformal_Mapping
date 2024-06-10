function MapTracks_grpFibers_seg_aug_tracks(input_file, roi)

% This is copied from MaptTracks_individualFibers
% Requirements are 
% 1. Main Data Dir
% 2. TracksFileName
% 3. SubjectName
addpaths;
readInputFile; %%%add line to Vikash's directory
input_file_other_subjs;
extension='.mat';
trk_dir= strcat(output_dir_tracks, 'Augmented_tracks/');
trk_cell_file=strcat(trk_dir, roi, extension);

if (exist(map_tracks_dir) == 0)
    mkdir(map_tracks_dir)
    end

%if file doesn't exist exit
if (exist(trk_cell_file) == 0) %it was trk_file
    return;
end


disp(subj)

output_file=strcat(map_tracks_dir, 'Mapped_tracks_', roi , extension);

if ~exist(output_file, 'file')
    sample_size=1;
    streamlinesFile=strcat(output_dir, 'streamlines.mat');
    Mdl_file = strcat(output_dir, 'Models.mat'); %%change is vikash's script

    load(streamlinesFile);
    mdl = load(Mdl_file);
    Mdl_ThetaVector = mdl.Mdl_ThetaVector;
    Mdl_PotVector = mdl.Mdl_PotVector;
    NewStreamLines_vector = mdl.NewStreamLines_vector;
    thetaVector_unique = mdl.thetaVector_unique;

    disp('Loaded streamlines and models');
    load(trk_cell_file);
    disp('Loaded Tracks cell');
    %% Map tracks 

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
        
     if (mod(i, 500) ==0)
        dispstring = [string(i), ' of ' , string(length(combine_tracks_cell)), ' completed.']
     end 

    end
    
    save(output_file, 'Mapped_tracks');
end
    disp (output_file);
end
