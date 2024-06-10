subjs=[12170111 12240219 12312537 12351268 12395685 12463343 12525030 12540186 12595653 12605052 12830673 6616456 6644759 7304803];

%training_subjs = [12170111 12240219 12312537 12351268 12395685 12463343 12525030 6616456 6644759 7304803];
training_subjs = [6644759];
trk_list={'AF_L','AF_R','CING_L','CING_R','CST_L','CST_R','DRTT_L','DRTT_R','FAT_L','FAT_R','IFOF_L','IFOF_R','ILF_L','ILF_R', 'MdLF_L','MdLF_R','OR_L','OR_R','SLF2_L','SLF2_R','SLF3_L','SLF3_R','UF_L','UF_R', 'VOF_L','VOF_R'};


addpaths;

base_data_dir='/raid/Data/FiberClustering/complete/';

base_tracts_dir='/raid/Data/FiberClustering/tracked/';
data_matrix = zeros(length(trk_list), length(training_subjs));

for tl=1:1:length(training_subjs)
    input_file=strcat(base_data_dir, string(training_subjs(tl)), '/input_file.txt');
    readInputFile;
    input_file_other_subjs;
    
    %Plot_TrksBoundVox(input_file);
    %ComputeConformalMapping(input_file);
    %PlotPotentialSurfaces(input_file)
   
    %% Now if everything is fine go ahead and map the tracks     
     %[header, tracks] = trk_read(trk_file_path);
     %header.n_count
    %streamlines_path = strcat(output_dir, 'streamlines.mat');
    %load(streamlines_path)
    
    %DivideTracks_trk_format(tracks, num_tracks_per_bundle, number_of_points_per_track, Padding, voxDim, output_dir_tracks)
    %clear subj FA_image_path output_dir trk_file_path output_dir_tracks roi_tracks_dir sep_output_dir map_tracks_dir
    
    %% Trk2Cell Conversion all fiber groups  
%     streamlines_path = strcat(output_dir, 'streamlines.mat');
%     load(streamlines_path)
%     trk_list = trk_list1;  
%     save(streamlines_path)
%     
%     for k = 1:1:length(trk_list)
%         trk_file_path = strcat(base_tracts_dir, string(subjs(t)), '/tracts/', trk_list{k}, '.trk');
%         if exist(trk_file_path, 'file')
%           filePath = strcat(output_dir_tracks, trk_list{k}, '.mat');
%           
%           if ~exist(filePath, 'file')
%             [header, tracks] = trk_read(trk_file_path);
%         
%             tracks_interpolated = trk_interp(tracks, number_of_points_per_track);
%             tracks_interpolated_str = trk_restruc(tracks_interpolated);
%             track_cell_result = ConvertTrk2Cell(tracks_interpolated_str, Padding, voxDim);
%             save(filePath, 'track_cell_result');
%           end
%         
%         end
%     end
%     
    %% Plot fiber groups and boundVox
%     trk_list1 = trk_list;
%     streamlines_path = strcat(output_dir, 'streamlines.mat');
%     load(streamlines_path)
%     load(streamlines_path)
%     trk_list = trk_list1;
%     fig = figure(); hold on; grid on;
%     for k = 9:1:12
%         filePath = strcat(output_dir_tracks, trk_list{k}, '.mat');
%         load(filePath)
%         [r, c] = ind2sub(length(trk_list), k);
%         subplot(2, 2, k-8)
%         plot3(boundVox(:,1), boundVox(:,2), boundVox(:, 3), '.')
%         hold on; grid on;
%         for l = 1:50:length(track_cell_result)
%             a = track_cell_result{l};
%             plot3(a(:,1), a(:, 2), a(:,3))
%             title(trk_list{k})
%         end
%     end
%     figure_name = strcat(output_dir, 'Tracks_part_2.fig');
%     savefig(fig, figure_name)

    %% Count number of tracks per bundle 
%     streamlines_path = strcat(output_dir, 'streamlines.mat');
%     load(streamlines_path)
%     
%     for k = 1:1:length(trk_list)
%         filePath = strcat(output_dir_tracks, trk_list{k}, '.mat');
%         load(filePath)
%         data_matrix(k, tl) =  length(track_cell_result);   
%     end
%     

    %% Augment tracks per bundle
    %ThickenFiberBundles(input_file)

    %% Map Tracks
%      MapTracks_indv_subjs_fiber_parts(input_file)
    for tr=1:1:length(trk_list)
        MapTracks_grpFibers_seg_aug_tracks(input_file, trk_list{tr})
        disp(trk_list{tr})
    end
     disp(training_subjs(tl))
end

