addpaths;
readInputFile;
input_file_other_subjs;

subj


track_dir = strcat(data_dir, 'VolParam/Trk_2_Cell/Augmented_tracks/')

mapped_track_dir = strcat(data_dir , 'VolParam/MappedTracks/')

base_output_dir = strcat(data_dir, 'Track_text_files_mapped_unmapped/');

if (exist(base_output_dir) == 0)
	mkdir(base_output_dir)
end

out_unmapped_dir = strcat(base_output_dir, 'Tracks/')
out_mapped_dir = strcat(base_output_dir, 'MappedTracks/')

if (exist(out_mapped_dir) ==0)
	mkdir(out_mapped_dir)
end

if (exist(out_unmapped_dir) == 0)
	mkdir (out_unmapped_dir)
end

roi = {'AF_L', 'AF_R', 'CING_L', 'CING_R', 'CST_L', 'CST_R', 'DRTT_L', 'DRTT_R', 'FAT_L', 'FAT_R', 'IFOF_L', 'IFOF_R', 'ILF_L', 'ILF_R', 'MdLF_L', 'MdLF_R', 'OR_L', 'OR_R', 'SLF2_L', 'SLF2_R', 'SLF3_L', 'SLF3_R', 'UF_L', 'UF_R', 'VOF_L', 'VOF_R'}

num = length(roi)

all_tracks = {}
all_mapped_tracks = {}

total_number_of_tracks = 0

for i = 1:num
	track_cell_path = strcat(track_dir, roi{i} , '.mat')
	mapped_track_cell_path = strcat(mapped_track_dir, 'Mapped_tracks_', roi{i}, '.mat')

	if (exist(track_cell_path) > 0)
		load(track_cell_path) ; 
		num_tracks_per_bundle = length(tracks_resampled_cell)
		all_tracks = [all_tracks; tracks_resampled_cell];
	end
	
	if (exist(mapped_track_cell_path) > 0)
		load(mapped_track_cell_path);
		num_tracks_per_bundle = length(Mapped_tracks);
		all_mapped_tracks = [all_mapped_tracks; Mapped_tracks];
	end

end

write_fiber_bundles_single_file(out_mapped_dir, 'all', all_mapped_tracks)


total_num_of_tracks = length(all_mapped_tracks)
number_of_points_per_track = 50 
M = zeros(total_num_of_tracks, number_of_points_per_track*3);
file_name = strcat(output_dir, 'Mapped_fiber_all.txt');

for i = 1:total_num_of_tracks
	a = all_mapped_tracks{i};
	b = reshape(a, 150, 1);
	M(i, :) = b;
end

dlmwrite(file_name, M, 'delimiter', '\t', 'precision', 7);

save(strcat(out_unmapped_dir, 'All_tracks.mat'), 'all_tracks');

