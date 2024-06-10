i = 1;
training_subj_list = [12170111  12463343  7304803];
prediction_dir = '/raid/Data/FiberClustering/complete/Processed_Fiber_data2/CNN_model/Prediction_Results2/';

for i =1:3

base_data_dir=strcat('/raid/Data/FiberClustering/complete/', string(training_subj_list(i)) , '/Track_text_files_mapped_unmapped/Tracks/');
tracks_file = strcat(base_data_dir, 'All_tracks.mat');
roi = {'AF_L', 'AF_R', 'CING_L', 'CING_R', 'CST_L', 'CST_R', 'DRTT_L', 'DRTT_R', 'FAT_L', 'FAT_R', 'IFOF_L', ...
    'IFOF_R', 'ILF_L', 'ILF_R', 'MdLF_L', 'MdLF_R', 'OR_L', 'OR_R', 'SLF2_L', 'SLF2_R', 'SLF3_L', 'SLF3_R', 'UF_L', 'UF_R', 'VOF_L', 'VOF_R'};

predict_file = strcat(prediction_dir, string(training_subj_list(i)), '/predicted_classes_float.txt');

prediction = readtable(predict_file);
a = prediction{:,:} + 1;

%% Find the indices and plot 

load(tracks_file);
% figure();
% hold on;
% for j =1:1000:size(all_tracks, 1)
%     x = all_tracks{j};
%     plot3(x(:,1), x(:,2), x(:,3));
% end

out_dir = strcat(prediction_dir, string(training_subj_list(i)), '/' );
% 
% for j = 1:26
%     ind = find(a==j);
%     track_group = {};
%     for k = 1:size(ind, 1) 
%         x = all_tracks{ind(k)};
%         track_group{k} = x;
%     end
%     disp(roi{j})
%     out_filename = strcat(out_dir, roi{j}, '.mat');
%     save(out_filename, 'track_group');
% end


%% plot compare ground truth vs prediction 
for j = 1:26
gt_dir = strcat('/raid/Data/FiberClustering/complete/', string(training_subj_list(i)), '/VolParam/Trk_2_Cell/Augmented_tracks/');
gt_filename = strcat(gt_dir, roi{j}, '.mat');
load(gt_filename)
predicted_filename = strcat(out_dir, roi{j}, '.mat');
load(predicted_filename)

    out_gt_filename = strcat(out_dir, roi{j} , '_GT', '.fig');
    out_pred_filename = strcat(out_dir, roi{j}, '_Pred', '.fig');

    fig = figure('visible', 'off'); hold on;
    for l = 1:size(track_group, 2)
        x = track_group{l};
        plot3(x(:,1), x(:, 2), x(:,3), 'm')
    end
    saveas(fig, out_pred_filename)
       
    fig = figure('visible', 'off'); hold on
    for l = 1:size(tracks_resampled_cell, 1)
        x = tracks_resampled_cell{l};
        plot3(x(:,1), x(:, 2), x(:,3), 'b')
    end
    saveas(fig, out_gt_filename)
    
end


end