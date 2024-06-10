function MapTracks_indv_subjs_fiber_parts(input_file)
  readInputFile;
  input_file_other_subjs;

  streamlinesFile=strcat(output_dir, 'streamlines.mat');
  Mdl_file = strcat(output_dir, 'Models.mat');

%   load(streamlinesFile);
  mdl = load(Mdl_file);
  Mdl_ThetaVector = mdl.Mdl_ThetaVector;
  Mdl_PotVector = mdl.Mdl_PotVector;
  thetaVector_unique = mdl.thetaVector_unique;
  NewStreamLines_vector = mdl.NewStreamLines_vector;
  
  output_dir_map = strcat(output_dir, 'Mapped_tracks_all_fibers/');
  if (exist(output_dir_map) == 0)
    mkdir(output_dir_map)
  end

  for d=1:1:101
    trk_cell_file=strcat(output_dir_tracks, 'Tracks_', num2str(d) , '.mat');%changed k to d
    load(trk_cell_file);

    Mapped_tracks=cell(length(tracks_resampled_cell),1);

    for i=1:1:length(tracks_resampled_cell)
      a = tracks_resampled_cell{i};
      parfor j=1:length(a)
          coordinate=a(j,:);
          [theta_interp, phi_interp] = interpolate_Weighted_matlab(Mdl_ThetaVector, coordinate, thetaVector_unique);
          [pot_interp] = interpolate_pot_Weighted_matlab(Mdl_PotVector, coordinate, NewStreamLines_vector);
          mapped_tracks_i(j,:) = [theta_interp, phi_interp, pot_interp];
      end
      Mapped_tracks{i}=mapped_tracks_i;
    end
    


     output_file=strcat(output_dir_map, 'Mapped_tracks_', num2str(d) , '.mat');
     save(output_file, 'Mapped_tracks');
    end


  end
 
