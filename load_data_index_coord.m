%% load Data
%% Make the point cloud
sizeFA=size(FAimage.img);
count=0;
for i=1:sizeFA(1)
    for j =1:sizeFA(2)
        for k=1:sizeFA(3)
            if (FAimage.img(i,j,k) > 0)
               count=count+1;
            end
        end
    end
end

tot_vox=count;
count=1;
vertices_idx = zeros(tot_vox, 3);
for i=1:sizeFA(1)
    for j =1:sizeFA(2)
        for k=1:sizeFA(3)
            if (FAimage.img(i,j,k) > 0)
                vertices_idx(count, :)=[i,j,k];
                count=count+1;
            end
        end
    end
end

vertices=vertices_idx;
delete vertices_idx;

