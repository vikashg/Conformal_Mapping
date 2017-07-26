The order of variables in the input file should be as follows:
Base data directory: $dir: /ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/
Subject name $subj: 0012310 // or get the subject name from the submission script if it is more convenient
FA image pathway $FA_image_path: sub directory path of the FA image along with file name for example Images/FA_image.nii
Output directory $output_dir: output file path
Segmented tracks file path $output_dir_tracks: path to directory containing the segmented tracks 
ROI fiber file name $roi_tracks_dir: path to the file containing all the rois (.trk input file)
Separated tracks $sep_output_dir: path to output Noisy tracks file

dir: /ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/
subj: 0012310 
FA_image_path: /ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/0012310/MNI_2_FA/FA_image.nii
output_dir: /ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/0012310/Vol_param_check
trk_file_path: /ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/0012310/Tracks/0012310_qball_pds_pico_trk.trk
output_dir_tracks: /ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/0012310/Trk_2_Cell/
roi_tracks_dir: /ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/0012310/segmented_tracks/
sep_output_dir: /ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/0012310/SeparateNoisyTracks/


*****MAKE SURE TO ADD A SLASH / AT THE END OF ALL DIRECTORIES*****
