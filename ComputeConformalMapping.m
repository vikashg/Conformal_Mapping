%% Read files from DTISearch
addpaths;
readInputFile;
input_file_other_subjs;
load_data_index_coord; %use this if no flipping is required; figure with
%boundary points and plot tracts (some) to check if aligned or not

%For HCP anterior posterior is flipped so use this 
%load_data_index_coord_flip_anter_poster;
%stepSizeforStreamLines =1; %%%%delete

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

%% Laplace Computation
voxData = LaplaceSolver(voxData, shapeCenter, gridSize_wPadding, eps);
[streamlines] = odeSolver(voxData, boundVox, count_BoundVox, stepSizeforStreamLines, shapeCenter);
ComputePointsonSphere;
ResampleStreamLines;
thetaVector=ComputeTheta(streamlines_uniq_resampled, stepSizeforStreamLines, shapeCenter);
%thetaVector_unique=unique(thetaVector, 'rows');

code_home = pwd;

cd(output_dir)
save streamlines;

cd(code_home);
%% Create the KD Tree structure for interpolation and save it in the output_dir CreateKDTree.m Assuming this file works and it will only work when stepSizeforStreamlines = 1. That is boundary voxels are not skipped 
CreateKDTree;
disp('Saved the KD Tree models')
