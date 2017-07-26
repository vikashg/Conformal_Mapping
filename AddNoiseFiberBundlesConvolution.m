addpaths;
readInputFile;
input_file_other_subjs;

trk_cell_dir=strcat(output_dir_tracks, '/Segmented_tracks/');
%trk_cell_dir=strcat(data_dir, '/Trk_2_Cell/Segmented_tracks/');
out_dir=strcat(output_dir_tracks, 'Resampled_augmented_convol/');

if (exist(out_dir) == 0)
     mkdir(out_dir)
end

%roi={'atr_l' ,'atr_r' ,'cc_frontal' ,'cc_occipital' ,'cc_parietal', 'cc_pocg' ,'cc_prcg', 'cc_temporal', 'cgc_l', 'cgc_r' , 'cst_l' ,'cst_r' ,'ifo_l' ,'ifo_r', 'ilf_l', 'ilf_r' ,'phc_l', 'phc_r' , 'slf_l' , 'unc_l', 'unc_r'}

roi = trk_list;
maxFibers = max_number_fibers;
sz = 10;
a=10;
b=100000;

for trk_num =1:length(roi)

roi{trk_num}
tracks_file = strcat(trk_cell_dir,  roi{trk_num}, '.mat');
%tracks_file = strcat(data_dir,  roi{trk_num}, '.mat');

if (exist(tracks_file) > 0)


load(tracks_file);
fibers_orig= track_cell;
numFibers = length(fibers_orig);

numFibers_2_generated = maxFibers - numFibers;
numFibers_generated_per_track = floor(numFibers_2_generated/numFibers);
if (numFibers_generated_per_track > 0)
count =1;
new_fibers_cell = cell(numFibers_generated_per_track*numFibers,1);
for i = 1:numFibers
    trk_i = fibers_orig{i};
    padded_trk_i = [flip(trk_i(1:5,:)); trk_i; flip(trk_i(46:end, :))];
    sigma_vec = a + (b-a).*rand(numFibers_generated_per_track, 1);
    
    for k =1:numFibers_generated_per_track
        x = linspace(-sz / 2, sz / 2, sz);
        gaussFilter = exp(-x .^ 2 / (2 * sigma_vec(k) ^ 2));
        gaussFilter = gaussFilter / sum (gaussFilter); % normalize
        trk_filt = [conv(padded_trk_i(:,1), gaussFilter, 'same') ...
                    conv(padded_trk_i(:,2), gaussFilter, 'same')...
                    conv(padded_trk_i(:,3), gaussFilter, 'same')];
                
        new_fibers_cell{count} = trk_filt(6:55, :);
        count = count +1;
    end
end
fiber_cell_all = cell(numFibers_generated_per_track*numFibers + numFibers,1);

else
    %generate a random index 
    start_idx = 1;
    end_idx = numFibers;
    idx_random = floor(start_idx + (end_idx - start_idx)*rand(numFibers_2_generated,1));
    new_fibers_cell = cell(numFibers_2_generated,1);
    sigma_vec = a + (b-a).*rand(numFibers_2_generated, 1);
    for i=1:numFibers_2_generated
        x = linspace(-sz / 2, sz / 2, sz);
        gaussFilter = exp(-x .^ 2 / (2 * sigma_vec(i) ^ 2));

        trk_i = fibers_orig{idx_random(i)};
        padded_trk_i = [flip(trk_i(1:5,:)); trk_i; flip(trk_i(46:end, :))];
    

         gaussFilter = gaussFilter / sum (gaussFilter); % normalize
         trk_filt = [conv(padded_trk_i(:,1), gaussFilter, 'same') ...
                     conv(padded_trk_i(:,2), gaussFilter, 'same')...
                     conv(padded_trk_i(:,3), gaussFilter, 'same')];

         new_fibers_cell{i} = trk_filt(6:55, :);
         
    end

         fiber_cell_all = cell(maxFibers,1);
end

fiber_cell_all(1:numFibers) = fibers_orig;
fiber_cell_all(numFibers + 1:end) = new_fibers_cell;
fibers_orig = fiber_cell_all;
tracks_resampled_cell = fibers_orig;
outFile=strcat(out_dir, roi{trk_num}, '.mat');

save(outFile, 'tracks_resampled_cell');

end
end
