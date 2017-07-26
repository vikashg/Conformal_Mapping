vl_feat_setup='/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/vlfeat-0.9.20/toolbox/vl_setup.m';
run (vl_feat_setup);

Nifti_matlab_path='/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/NIfTI_20140122';
addpath(Nifti_matlab_path);

Tracvispath='/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/Trackvis-matlab/along-tract-stats-master/paths.m';
run(Tracvispath);

specClusteringpath='/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/spectralclustering-1.1';
addpath(specClusteringpath);

iso2meshpath='/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/iso2mesh';
addpath(iso2meshpath)
addpath('/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/geom3d-2016.03.02/geom3d/geom3d');
addpath('/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/geom3d-2016.03.02/geom3d/meshes3d');

addpath('/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/intriangulation');
addpath('/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/inpolyhedron');
addpath('/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/vectorized_meshgrid');
addpath('/ifs/loni/faculty/thompson/adni2/scan_1/Vikash_process/Softwares/MATLAB/iso_surfs_mid');
