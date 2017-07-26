base_dir=$1
subj=$2
input_file=$3

apps_dir=/ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization/JobSubmission_scripts_hpc
roi=(atr_l atr_r cc_frontal cc_occipital cc_parietal cc_temporal cgc_l cgc_r cst_l cst_r ifo_l ifo_r ilf_l ilf_r slf_l unc_l unc_r)

for j in "${roi[@]}"
do
    trk_file=${base_dir}/${subj}/NewResults/Trk_2_Cell/Resampled_augmented_convol/$j.mat
    map_file=${base_dir}/${subj}/NewResults/Mapped_tracks/Mapped_tracks_$j.mat
    echo $map_file
    if [ -f $trk_file ] && [ ! -f $map_file ]; then 
    echo $trk_file
    qsub -v subj=${subj},roi=$j,input_file=$input_file ${apps_dir}/Map_tracks_atomic_training_data.sh
    fi
done
