addpaths;
input_file_other_subjs;

%subj='0035019'
%subj_dir=strcat('/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/', subj)

trk_cell_dir=strcat(data_dir, '/Trk_2_Cell/Segmented_tracks/');
out_dir=strcat(subj_dir, '/Trk_2_Cell/Augmented_tracks/');

if (exist(out_dir) == 0)
     mkdir(out_dir)
end

roi={'atr_l' ,'atr_r' ,'cc_frontal' ,'cc_occipital' ,'cc_parietal', 'cc_pocg' ,'cc_prcg', 'cc_temporal', 'cgc_l', 'cgc_r' , 'cst_l' ,'cst_r' ,'ifo_l' ,'ifo_r', 'ilf_l', 'ilf_r' ,'phc_l', 'phc_r' , 'slf_l' , 'unc_l', 'unc_r'}

maxPoints = max_number_fibers;
numPoints=number_of_points_per_track;

for trk_num =1:length(roi)
roi{trk_num}
tracks_file = strcat(data_dir,  roi{trk_num}, '.mat');
load(tracks_file);
fibers_orig= tracks_resampled_cell;
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

fiber_cell_all(1:numFibers) = tracks_resampled_cell;
fiber_cell_all(numFibers + 1:end) = new_fibers_cell;
tracks_resampled_cell = fiber_cell_all;

outFile=strcat(out_dir, roi{trk_num}, '.mat');

save(outFile, 'tracks_resampled_cell');

end
