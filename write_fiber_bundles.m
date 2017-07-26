function  write_fiber_bundles(output_dir, roi, tracks)

output_dir = strcat(output_dir, roi)
if (exist(output_dir) ~= 1)
    mkdir(output_dir)
end

num_tracks = length(tracks);
idx = 1;
for i = 1:num_tracks
    a=tracks{i};
    file_name = strcat(output_dir, '/Mapped_fiber_', num2str(idx), '.txt');
    fileID1 = fopen(file_name,'w');
    fprintf(fileID1,  '%6.5f \t %6.5f \t %6.5f\n' , a');    
    fclose(fileID1);
    b=flip(a);
    file_name = strcat(output_dir, '/Mapped_fiber_', num2str(idx+1), '.txt');
    fileID2 = fopen(file_name, 'w');
    fprintf(fileID1,  '%6.5f \t %6.5f \t %6.5f\n' , b');    
    fclose(fileID2);
    idx = idx +2;
end
end
