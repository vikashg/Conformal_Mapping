base_dir=/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param
data_dir=${base_dir}/Input_files
while read line; do 
    qsub -v subj=$line submit_jobs_training_data.sh
    #input_file=${data_dir}/input_file_${line}.txt
    #bash call_MapTracks_atomic_training_data.sh ${base_dir} ${line} ${input_file}
done < ${data_dir}/training_subj_list.txt
