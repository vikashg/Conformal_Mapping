function ThickenFiberBundles(input_file)
addpaths;
readInputFile;
input_file_other_subjs;

%subj='0035019'
%subj_dir=strcat('/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/', subj)

trk_cell_dir=strcat(output_dir, 'Trk_2_Cell/');
augmented_tracks_dir=strcat(output_dir, 'Trk_2_Cell/Augmented_tracks/');

if ~exist(augmented_tracks_dir, 'dir')
     mkdir(augmented_tracks_dir)
end

maxPoints = max_number_fibers;
numPoints=number_of_points_per_track;

for trk_num =1:length(trk_list)
tracks_file = strcat(trk_cell_dir,  trk_list{trk_num}, '.mat');
load(tracks_file);
fibers_orig= track_cell_result;
numFibers = length(fibers_orig);

numFibers_2_generated = maxPoints - numFibers;
numFibers_generated_per_track = floor(numFibers_2_generated/numFibers);

new_fibers_cell = cell(numFibers_generated_per_track*numFibers,1);
count =1;
for i = 1:length(fibers_orig)
    track_i = fibers_orig{i};
    new_track = zeros(numPoints, 3);
    for k =1:numFibers_generated_per_track
        rand_temp=rand;
        for j =1:numPoints
            new_track(j,:) = track_i(j,:) + rand_temp*(ones(1,3));       
        end
        new_fibers_cell{count} = new_track;
        count = count +1;
    end    
end

fiber_cell_all = cell(numFibers_generated_per_track*numFibers + numFibers,1);

fiber_cell_all(1:numFibers) = track_cell_result;
fiber_cell_all(numFibers + 1:end) = new_fibers_cell;
tracks_resampled_cell = fiber_cell_all;
outFile=strcat(augmented_tracks_dir, trk_list{trk_num}, '.mat');
save(outFile, 'tracks_resampled_cell');

end
end