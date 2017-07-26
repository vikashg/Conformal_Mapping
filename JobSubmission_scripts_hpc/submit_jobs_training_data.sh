#!/bin/bash
#$ -N VolParam_training_data
#$ -o /ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization/JobSubmission_scripts_hpc/logs
#$ -j y

# set environment
# source /usr/usc/matlab/default/setup.sh
matlab_dir=/usr/local/bin
script_dir=/ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization/JobSubmission_scripts_hpc

# matlab scripts dir
dir=/ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization/
cd ${dir}

subject=${subj}
base_dir=/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/
input_base_dir=${base_dir}/Input_files
input_file=${input_base_dir}/input_file_${subject}.txt

# ${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file'; subj='$subj'; ComputeConformalMapping; exit;"
# ${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file'; subj='$subj'; Wrapper_ConvertTrk2Cell_training_data; exit;"
# ${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file'; subj='$subj'; AddNoiseFiberBundlesConvolution; exit;"
#### At this step call the Map tracks function from the other 
${matlab_dir}/matlab -nodesktop -nosplash -r "subj = '$subj'; input_file = '$input_file'; Write_files_segmented_tracks_train_subj; exit"
