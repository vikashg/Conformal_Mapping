#!/bin/bash
#PBS -N VolParam
#PBS -o /ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization/JobSubmission_scripts_hpc/logs

#set environment
# source /usr/usc/matlab/default/setup.sh
matlab_dir=/usr/local/bin

#matlab scripts dir
dir=/ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization
cd ${dir}
subject=${subj}
input_base_dir=/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/Input_files
input_file=${input_base_dir}/input_file_${subject}.txt

# rm -rfv /auto/rcf-proj2/vg/Data/AD_DOD/${subject}/Vol_param*

${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file'; subj='$subj'; ComputeConformalMapping; exit;"

