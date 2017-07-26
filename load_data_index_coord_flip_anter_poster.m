%% load Data
%% Make the point cloud
sizeFA=size(FAimage.img);
count=0;
FA_bin = FAimage.img > 0; 

tot_vox=sum(FA_bin(:));
count=1;

idx_a = find(FA_bin > 0);
[I, J, K] = ind2sub(sizeFA, idx_a);

%disp('Vertices');
vertices_a=[I, J, K];

%% Now the code for the flipping the anterior - posterior slices a.k.a. Y direction 
b_flipped_ant_post = FAimage.img;

l = sizeFA(2); 
for i = 1:sizeFA(2)
    b_flipped_ant_post(:,l,:) = FAimage.img(:,i,:);
    l = l-1;
end

idx_b = find(b_flipped_ant_post>0); 
[I,J,K] = ind2sub(sizeFA, idx_b);

vertices_b = [I, J, K];
delete I J K; 
vertices = vertices_b; %because it is flipped 

shapeCenter_woPad(2) = sizeFA(2) - shapeCenter_woPad(2) + 1; % flipping the shape center inaccordance with line 27 




