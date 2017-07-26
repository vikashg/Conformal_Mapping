addpaths;
readInputFile;
number_of_points_per_track = 50;
dir=input_cell{1}
data_dir=strcat(dir, subj, '/')
trk_list={'atr_l', 'atr_r' ,'cc_frontal', 'cc_occipital', 'cc_parietal', 'cc_temporal', 'cgc_l', 'cgc_r' , 'cst_l' ,'cst_r' ,'ifo_l' ,'ifo_r', 'ilf_l', 'ilf_r' , 'slf_l' , 'unc_l', 'unc_r'}

subj

roi_num = length(trk_list);

for i = 1:roi_num 
    roi=trk_list{i};
    %track_file_dir=strcat(data_dir, 'Mapped_tracks_Segmented_Aug_Convol/');
    track_file_dir=strcat(data_dir, 'NewResults/Mapped_tracks/Segmented_tracks_coarse/');
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
    %write_fiber_bundles(output_dir, roi, Mapped_tracks);
    write_fiber_bundles_single_file(output_dir, roi, Mapped_tracks); 

disp(strcat(roi, ' Done'))
end

disp('Done');
