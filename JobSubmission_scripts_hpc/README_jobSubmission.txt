1. First go to the ../scripts/ folder and generate input files
2. Run wrapper_submit_jobs.sh 
    it will submit the jobs for all subjects for Conformal Mapping

3. Run wrapper_submit_jobs_training_subjects.sh, it will call submit_jobs_training_subjects.sh and will submit jobs for mapping the manually segmented tracks

#### 
For processing the test subjects. Follow this particular protocol
1. The main wrapper for submitting jobs is wrapper_submit_jobs.sh In this file change the path where your input files are located and then call it. I tiwll in turn call submit_jobs_indv_subjs.sh
    The submit_jobs_indv_subjs first computes the conformal mapping for all the test subjects and then calls another Matlab function Wrapper_ConvertTrk2Cell_indv_subjs_mod.m The later function divides the large trk file into smaller chunks for better memory management. 

Once the large trk file is divided like this. Use the following wrapper to call the individual chunks for mapping. For doing so, comment out the qsub lines on 6 and 7 in wrapper_submit_jobs.sh and uncomment line 10 . 
So the flow of command is as follows
    wrapper_submit_jobs ---> call_MapTracks_atomic_indv_subjs.sh --> Map_tracks_atomic.sh --> MapTracks_indv_subjs.m 
Just in case if you have newly copied the code change the directory on line 5, i.e., ${apps_dir}
