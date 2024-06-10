training_subjs = [12170111 12240219 12312537 12351268 12395685 12463343 12525030 6616456 6644759 7304803];
base_data_dir='/raid/Data/FiberClustering/complete/';

testing_subjs = [12170111 12463343 7304803]

%for i = 1:3
%  subj = training_subjs(i)
%  input_file=strcat(base_data_dir, string(training_subjs(i)), '/input_file.txt');
%  Write_files_segmented_tracks_train_subj

%end

for i = 1:3
	subj = testing_subjs(i)
	input_file = strcat(base_data_dir, string(subj), '/input_file.txt')
	disp(input_file)
	Write_files_test_subj_mapped_tracks_unmapped_tracks
end


