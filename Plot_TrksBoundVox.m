addpaths;
readInputFile;
input_file_other_subjs;

if (exist(qc_dir) == 0)
     mkdir(qc_dir)
end

load_data_index_coord;
%load (strcat(output_dir_T1, '/streamlines.mat')'

%load_data_index_coord_flip_anter_poster;
load(trk_file_name)

copied from ComputeConformalMapping because we do not need to compute the
Laplace Computation

gridSize_wPadding = gridSize + Padding;
sx=gridSize_wPadding(1); sy = gridSize_wPadding(2); sz = gridSize_wPadding(3);
numOfVoxels=sx*sy*sz;
TotalNumberOfPoints=length(vertices);
points=zeros(TotalNumberOfPoints, 3);
for i=1:TotalNumberOfPoints
    points(i,:) = vertices(i,:) + Padding/2;
end

%% Create Data Structure
voxData=ones(sx,sy,sz,5);
for i = 1:TotalNumberOfPoints
    x=points(i,1); y=points(i,2); z= points(i,3);
    voxData(x,y,z,1)=2;
    voxData(x,y,z,2)=10;
    voxData(x,y,z,3)=rand()*potential_multiplier;
end

disp('Created data structure')

%% Mark Boundary Voxels
temp_flag_val=10;
voxData = MarkBoundaryVer4(voxData, sx, sy,sz, temp_flag_val);
count_BoundVox=0;
boundVox=[];
for i = 1:gridSize_wPadding(1)
    for j = 1: gridSize_wPadding(2)
        for k = 1: gridSize_wPadding(3)
            if (voxData(i,j,k,2) == 100)
                 voxData(i,j,k,1) = 3;
                voxData(i,j,k,2) = 10;
                voxData(i,j,k,3) = 1.0*potential_multiplier;
                 count_BoundVox = count_BoundVox+1;
                 boundVox=[boundVox; [i,j,k]];
            end
        end
    end
end
%%% Changing ShapeCenter here 
shapeCenter = shapeCenter_woPad + Padding/2;

% % For the moment not layering the potentials 
flag = 3;
temp_flag_val=10;
voxData = MarkBoundaryVer4(voxData, sx, sy,sz, temp_flag_val);

for i = 1:gridSize_wPadding(1)
    for j = 1: gridSize_wPadding(2)
        for k = 1: gridSize_wPadding(3)
            if (voxData(i,j,k,2) == 100)
                voxData(i,j,k,1) = 4;
                voxData(i,j,k,2) = 10;
                voxData(i,j,k,3) = 1.5*potential_multiplier;
            end
        end
    end
end


flag = 4;
temp_flag_val=10;
voxData = MarkBoundaryVer4(voxData, sx, sy,sz,temp_flag_val );
test3=[];
for i = 1:gridSize_wPadding(1)
    for j = 1: gridSize_wPadding(2)
        for k = 1: gridSize_wPadding(3)
            if (voxData(i,j,k,2) == 100)
                voxData(i,j,k,1) = 5;
                voxData(i,j,k,2) = 10;
                voxData(i,j,k,3) = 2.0*potential_multiplier;
                test3=[test3; [i,j,k]];
            end
        end
    end
end

% Assign potential to outSidePoints

for i=1:sx
    for j =1:sy
        for k=1:sz
            if (voxData(i,j,k, 1) ==1)
                voxData(i,j,k,3)=5*potential_multiplier;
            end
        end
    end
end

% Dont change anything so far all good

disp('Assigned potential to outside_points')

%% Load Track File

[header, tracks] = trk_read(trk_file_path);
trk_length_vector = trk_length(tracks);
filtered_tracks_idx = find(trk_length_vector < length_threshold_max & trk_length_vector > length_threshold_min);

tracks_filtered = tracks(filtered_tracks_idx);

tracks_cell=cell(length(tracks_filtered),1);
    for i=1:1:length(tracks_filtered)
        track_i = tracks_filtered(i);

        % Pad and convert to voxel coordinates
        b=zeros(track_i.nPoints, 3);
        for j =1 : track_i.nPoints
            b(j, :)  = track_i.matrix(j,:)./voxDim + Padding/2;
        end
        tracks_cell{i} = b;
    end

    track_cell_result = tracks_cell;

%% Plot Figure

figure(); 
hold on; grid on; 
plot3(boundVox(:,1), boundVox(:,2), boundVox(:,3), '.');
plot3(shapeCenter(1), shapeCenter(2), shapeCenter(3), 'r*');
for k=1:100:length(track_cell_result)
    a = track_cell_result{k};
    plot3(a(:,1), a(:,2), a(:,3));
end

view([90,0,0]);
xlabel('x');
zlabel('z');
ylabel('y');

saveas(gcf,strcat(qc_dir, '/', subj, '_trk_QC.png'), 'png');
Image = strcat(qc_dir, '/', subj, '_trk_QC.png');

%pause;
close all;
%end