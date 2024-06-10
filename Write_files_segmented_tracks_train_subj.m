addpaths;
readInputFile;
input_file_other_subjs
number_of_points_per_track = 50;
dir=input_cell{1}
data_dir=strcat(dir, subj, '/')
subj
roi_num = length(trk_list);

for i = 1:roi_num 
    roi=trk_list{i};
    track_file_dir=strcat(data_dir, 'VolParam/MappedTracks/');
    Mapped_trk_file=strcat(track_file_dir, 'Mapped_tracks_', roi , '.mat');

    if (exist(Mapped_trk_file) == 0)
       disp (strcat(Mapped_trk_file, ' not found'));
         exit;
    end

    %load((Mapped_trk_file) == 0)
    load(Mapped_trk_file)
    output_dir = strcat(track_file_dir, 'Tracks_text_files/');

    if (exist(output_dir) == 1)
        exit;
    else
        mkdir (output_dir)
    end

    start_indx=1;
    write_fiber_bundles_single_file_flipped(output_dir, roi, Mapped_tracks);

    %write_fiber_bundles(output_dir, roi, Mapped_tracks);
    %write_fiber_bundles_single_file(output_dir, roi, Mapped_tracks); 

disp(strcat(roi, ' Done'))
end

disp('Done');
