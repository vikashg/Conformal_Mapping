base_dir=$1
subj=$2
input_file=$3

apps_dir=/ifs/loni/faculty/thompson/four_d/vgupta/Tools/Codes_modded_by_Sophie/Volumetric_Parameterization/JobSubmission_scripts_hpc

for j in `seq 1 40`
do
    trk_file=${base_dir}/$subj/NewResults/Trk_2_Cell/All_fibers/Tracks_$j.mat
    map_file=${base_dir}/$subj/NewResults/Mapped_tracks/Mapped_tracks_$j.mat
    echo ${trk_file}
    echo $map_file
    if [ -f $trk_file ] && [ ! -f $map_file ]; then
    echo $j
    qsub -v subj=$subj,d=$j,input_file=$input_file ${apps_dir}/Map_tracks_atomic.sh
    fi
done

