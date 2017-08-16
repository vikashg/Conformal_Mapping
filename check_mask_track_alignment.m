addpaths;
fid = fopen(input_file)
input_cell = cell(4,1)
i = 1
tline = fgetl(fid)
while ischar(tline)
     temp_Cell{i} = tline;
     tline = fgetl(fid);
     i=i+1;
end
input_cell = temp_Cell;
clear temp_Cell;

dir = input_cell{1}
subj= input_cell{2}
FA_img_path = input_cell{3}
trk_file_path = input_cell{4}

output_dir=strcat(dir, '/', subj, '/', 'check_alignment_tracks_mask/')
if (exist(output_dir) == 0)
  mkdir(output_dir)
end

FAimage= load_nii(FA_img_path);
voxDim = FAimage.hdr.dime.pixdim(2:4);
Padding=[20, 20, 20];

load_data_index_coord;

gridSize = size(FAimage.img)
gridSize_wPadding = gridSize + Padding;
sx=gridSize_wPadding(1); sy = gridSize_wPadding(2); sz = gridSize_wPadding(3);
numOfVoxels=sx*sy*sz;
TotalNumberOfPoints=length(vertices);

points=zeros(TotalNumberOfPoints, 3);
for i=1:TotalNumberOfPoints
    points(i,:) = vertices(i,:) + Padding/2;
end

%% Create Data Structure
potential_multiplier=10
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

%% Now work with the fibers 
[header, tracks] = trk_read(trk_file_path);
track_cell_result = ConvertTrk2Cell(tracks, Padding, voxDim)

cd(output_dir)
save result;
