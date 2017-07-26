function DivideTracks_trk_format(tracks, num_tracks_per_bundle, number_of_points_per_track, Padding, voxDim, output_dir)
    num_tracks = length(tracks); 
    num_bundles = floor(num_tracks/num_tracks_per_bundle);
    
    k_start = 1;
    
    for i = 0:num_bundles
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
        
        tracks_part_temp = tracks(k_start:k_end);
        tracks_interpolated = trk_interp(tracks_part_temp, number_of_points_per_track);
        tracks_interpolated_str = trk_restruc(tracks_interpolated);
        tracks_resampled_cell =  ConvertTrk2Cell(tracks_interpolated_str, Padding, voxDim);         
        
        filePath = strcat(output_dir, 'Tracks_', divnum_s, '.mat');
        save(filePath, 'tracks_resampled_cell');
        
        dispString = strcat('Part ' , divnum_s, ' written.');
                         
    end
end
