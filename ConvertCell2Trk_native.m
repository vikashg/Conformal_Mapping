function result = ConvertCell2Trk_native(tracks_cell, number_of_points, flag_interp)

num_tracks = length(tracks_cell);

for i=1:1:num_tracks
    a= tracks_cell{i};
    tracks_new(i).nPoints = length(a);
    tracks_new(i).matrix = a;

end

if (flag_interp == 1)
    tracks_interp = trk_interp(tracks_new, number_of_points);
    tracks_interp_str = trk_restruc(tracks_interp);
    result = tracks_interp_str;
else
    result = tracks_new;
end
