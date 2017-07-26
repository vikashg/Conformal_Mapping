#$ -N "mapTracks"
#$ -o /ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization/JobSubmission_scripts_hpc/logs1
#$ -j y

matlab_dir=/usr/local/bin
dir=/ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization
cd ${dir}
subject=${subj}
d=$d

${matlab_dir}/matlab -nodesktop -nosplash -r "input_file='${input_file}', subj='$subj', d='$d' ; MapTracks_indv_subjs; exit;"

