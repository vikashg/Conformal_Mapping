function DivideTracks(tracks_cell, num_tracks_per_bundle, output_dir)
    
    num_tracks = length(tracks_cell);
    num_bundles = floor(num_tracks/num_tracks_per_bundle);    
    
    k_start =1 ; 
    all_tracks = tracks_cell; 
    clear tracks_cell;
    
    for i = 0 : num_bundles
        k_start = i*num_tracks_per_bundle + 1;
        k_end_temp = (i+1)*num_tracks_per_bundle;
        k_end = 0;
        
        if (k_end_temp > num_tracks)
            k_end = num_tracks;
        else
            k_end = k_end_temp;
        end
        
        divnum_s = num2str(i+1);
        k_start 
        k_end
        
        tracks_cell_temp = all_tracks(k_start:k_end);
        
%% Now resample the tracks 
        tracks_resampled = ConvertCell2Trk_native(tracks_cell_temp, num_points_per_track, 1);
        tracks_resampled_cell = ConvertTrk2Cell_native(tracks_resampled);

        output_file_name = strcat(output_dir, 'Tracks_', divnum_s, '.mat');
        save(output_file_name, 'tracks_resampled_cell');    
    end 


end
