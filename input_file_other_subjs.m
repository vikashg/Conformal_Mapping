dir=input_cell{1};
subj = input_cell{2};
FA_image_path=input_cell{3};
output_dir = input_cell{4};
trk_file_path = input_cell{5};
output_dir_tracks = input_cell{6};
roi_tracks_dir = input_cell{7};
sep_output_dir = input_cell{8};
map_tracks_dir = input_cell{9};

%subj='0012310';
data_dir=strcat(dir, subj, '/');
shapecenter_file=strcat(data_dir, 'MNI_2_FA/ShapeCenter.txt');
shapeCenter_woPad = load(shapecenter_file);

Padding=[20, 20, 20];
FAimage=load_nii(FA_image_path);
voxDim = FAimage.hdr.dime.pixdim(2:4);

if (exist(output_dir) == 0)
    mkdir(output_dir);
end


%% Parameters
gridSize=size(FAimage.img);
potential_multiplier=1;
stepSizeforStreamLines=1; % density of streamlines; increase the number for fast computations 
stepSizeStreamLinesPlot=1;
stepSizeforTracks=1;
stepSizeforTracksPlot=10;
eps=1e-4; %% Accuracy of the computation lower it for increased accuracy = lowered from 1e-1 for more accuracy

%% Parameters for tracks
track_sample_size = 1;
number_of_points_per_track = 50;
num_tracks_per_bundle=10000;
length_threshold=50;

%% Parameters for storing tracks
if (exist(output_dir_tracks) == 0)
    mkdir (output_dir_tracks);
end

%%Parameters for separating tracks
if (exist(sep_output_dir) == 0)
    mkdir (sep_output_dir);
end

%% Parameters for length thresholding on test subjects Not needed for training subjects 
length_threshold_min = 35; %change from 35 to 33
length_threshold_max = 230; 

%% Parameters for convolutions on the training dataset 
max_number_fibers=7500;

%% List of tracks to be considered for training
%trk_list={'atr_l', 'atr_r' ,'cc_frontal', 'cc_occipital', 'cc_parietal', 'cc_temporal', 'cgc_l', 'cgc_r' , 'cst_l' ,'cst_r' ,'ifo_l' ,'ifo_r', 'ilf_l', 'ilf_r' , 'slf_l' , 'unc_l', 'unc_r'} %, 'cc_prcg', 'cc_pocg'};
trk_list={'atr_l', 'atr_r' ,'cc_frontal', 'cc_occipital', 'cc_parietal', 'cc_temporal', 'cgc_l', 'cgc_r' , 'cst_l' ,'cst_r' ,'ifo_l' ,'ifo_r', 'ilf_l', 'ilf_r' , 'slf_l'} %, 'cc_prcg', 'cc_pocg'};
%trk_list={'atr_l', 'atr_r' ,'cc_frontal', 'cc_occipital', 'cc_parietal', 'cc_pocg', 'cc_prcg', 'cc_temporal', 'cgc_l', 'cgc_r' , 'cst_l' ,'cst_r' ,'ifo_l' ,'ifo_r', 'ilf_l', 'ilf_r' , 'slf_l' , 'unc_l', 'unc_r', 'pocg-parietal_r', 'pocg-parietal_l', 'pocg-parietal_r', 'prcg-pocg_l', 'prcg-pocg_r', 'occipital_l', 'occipital_r', 'fronto-prcg_l', 'fronto-prcg_r', 'phc_l', 'phc_r'};
