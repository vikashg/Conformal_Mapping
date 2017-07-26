#!/bin/bash
#$ -o /ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization/JobSubmission_scripts_hpc/logs
#$ -j y
#set environment
matlab_dir=/usr/local/bin
#matlab scripts dir
dir=/ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization
cd ${dir}

subject=${subj}
input_base_dir=/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/Input_files
base_dir=/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param
input_file=${input_base_dir}/input_file_${subject}.txt

# ${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file'; subj='$subj'; ComputeConformalMapping; exit;"
#only doing it for coarse segmentation from Conor

# ${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file'; subj='$subj'; Wrapper_ConvertTrk2Cell_indv_subjs_grp_fibers; exit;"
# ${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file'; subj='$subj'; Wrapper_ConvertTrk2Cell_indv_subjs_mod; exit;"
# ${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file'; subj='$subj'; Write_files_segmented_tracks_test_subj; exit;"
${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file'; subj='$subj'; recombine_all_trk_grps; exit;"
