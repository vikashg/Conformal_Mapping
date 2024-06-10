addpaths;
training_subjs = [12170111]


trk_list={'AF_L','AF_R','CING_L','CING_R','CST_L','CST_R','DRTT_L','DRTT_R','FAT_L','FAT_R','IFOF_L','IFOF_R','ILF_L','ILF_R', 'MdLF_L','MdLF_R','OR_L','OR_R','SLF2_L','SLF2_R','SLF3_L','SLF3_R','UF_L','UF_R', 'VOF_L','VOF_R'};

base_data_dir = strcat('/raid/Data/FiberClustering/complete/' ,string(12170111), '/VolParam/Trk_2_Cell/')

all_tracks = [];

for i=1:1:length(trk_list)
	fn = strcat(base_data_dir, trk_list{i}, '.mat')
	load(fn)
	length(track_cell_result)
	all_tracks = [all_tracks; track_cell_result]; 
    pause
end
all_tracks
