function PlotFiberGroup(track_cell_filepath)
    load(track_cell_filepath)
    figure(); hold on; grid on;
    for i = 1:1:length(tracks_resampled_cell)
        a = tracks_resampled_cell{i};
        plot3(a(:,1), a(:, 2), a(:,3))
    end
end