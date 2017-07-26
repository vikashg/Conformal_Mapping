base_dir=/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param
data_dir=${base_dir}/Input_files

while read line; do 
input_file=$data_dir/input_file_${line}.txt

#qsub -v subj=$line submit_jobs_indv_subjs.sh
#bash call_MapTracks_atomic_indv_subjs.sh $base_dir $line $input_file
bash call_MapTracks_atomic_indv_subjs_fiber_grp.sh $base_dir $line $input_file

done < ${data_dir}/subj_list.txt
