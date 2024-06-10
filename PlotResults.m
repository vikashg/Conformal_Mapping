  streamlinesFile=strcat(output_dir, 'streamlines.mat');
  load(streamlinesFile)
  figure();
  hold on; grid on;
  plot3(boundVox(:,1), boundVox(:,2), boundVox(:,3), '.')
  for d=1:10:101
    trk_cell_file=strcat(output_dir_tracks, 'Tracks_', num2str(d) , '.mat');%changed k to d
    for i = 1: 5: length(tracks_resampled_cell)
        a = tracks_resampled_cell{i};
        plot3(a(:,1), a(:, 2), a(:, 3))
    end
    
  end