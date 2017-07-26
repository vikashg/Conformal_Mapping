addpaths; 
readInputFile;
input_file_other_subjs; 

subj

num_file_dir = strcat(data_dir, 'Trk_2_Cell/');
num_txt = strcat(num_file_dir, 'num_parts.txt');
%num_parts = load(strcat(num_file_dir, 'num_parts.txt'));

track_file_dir = strcat(data_dir, 'Mapped_tracks/');

output_dir = strcat(track_file_dir, 'Track_text_files/');

if (exist(output_dir) == 0) 
    mkdir(output_dir);
end

num=50;
%num= num_parts;

%count = 1;
%i=1;

for i = 1:num
    track_cell_path = strcat(track_file_dir, 'Mapped_tracks_' , num2str(i), '.mat');
    
    if (exist(track_cell_path) > 0)    
        load(track_cell_path);
        num_tracks_per_bundle = length(Mapped_tracks);
        start_idx = 1 + (i-1)* num_tracks_per_bundle;
        write_fiber_bundles_test_subjs(output_dir, start_idx, Mapped_tracks);
    end
end
