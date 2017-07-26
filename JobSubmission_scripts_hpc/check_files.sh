subj_list=/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param/Input_files/subj_list.txt
data_dir=/ifs/loni/faculty/thompson/four_d/Faisal/Projects/NeuralNet_TBI/AD_DOD_vol_param
while read line; do 
file=${data_dir}/$line/NewResults/Trk_2_Cell/Segmented_tracks

if [ -f $file ]; then
    echo $line
fi

done < ${subj_list}
