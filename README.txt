Step 0: Check if the tracks and the images are in alignment in the matlab
environment 
for anterior-posterior flip as in the case of the HCP data use the file
load_data_index_coord_flipped_anter_post.m for flipping the vertices 

Step 1: Generate Conformal Maps 
    The files that will generate conformal map is called ComputeConformalMapping.m 
    // need to write a shell script for job submissions 

Step 2: Convert the .trk files to cell file for further processing. There are again 2 options here. For the training data, do convert for separate ROIs, for the test data do the conversion on the whole trk file at once
    2a. run Wrapper_ConvertTrk2Cell_training_data.m for the training data. 
    2b. run Wrapper_ConvertTrk2Cell_indv_subjs_mod.m for the test data. This file also divides the tract bundles into smaller groups for parallel computation. 
    
Step 3: For the training subjects, augment the data using convolutions. File
to run AddNoiseFiberBundlesConvolution.m. The output is saved in
${dir}/${subj}/Trk_2_Cell/Resampled_augmented_convol

Step 4: Do mapping of the tracts using MapTracks. There are 2 options here one for the training data and the other for the test subjects. If there is the training data, do parallel computation on the ROIs (region of interests). For the test data divide the tracts into several groups (lets say 10) to increase the computation speed. Then we do combine the mapped tracts into one. 

Step 5: Write the mapped fibers in text files using the Write_files_XXXX
files. As usual there are two options here. First to write the files for the
training subjects and one should use Write_files_segmented_tracks_train_subj.m
for the other one is Write_files_test_subj.m. These files should take the
Mapped tracks in step 4 and write text files to be read using Python for
computation 

All the matlab work is complete now! Congratulations ~~

Author: Vikash Gupta  
