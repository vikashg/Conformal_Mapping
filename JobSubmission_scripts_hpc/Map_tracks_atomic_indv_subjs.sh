#$ -j y
#$ -o /ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization/JobSubmission_scripts_hpc/logs
#$ -N "MapTracks_grp"

matlab_dir=/usr/local/bin

dir=/ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization
cd ${dir}

${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='$input_file', subj='$subj', roi='$roi'; MapTracks_grpFibers_indv_subjs; exit;" 
 
