function voxData = LaplaceSolver(voxData, shapeCenter, gridSize_wPadding, eps)
count=0;
voxData(shapeCenter(1), shapeCenter(2), shapeCenter(3), 3)=0;
voxData(shapeCenter(1), shapeCenter(2), shapeCenter(3), 2)=1;
voxData(shapeCenter(1), shapeCenter(2), shapeCenter(3), 1)=10;
%potvec=ones(3000000, 1)*200;

for i =1:gridSize_wPadding(1)
    for j = 1:gridSize_wPadding(2)
        for k = 1:gridSize_wPadding(3)
            if (voxData(i,j,k,1) ==2)
                count = count+ 1;
            end
        end
    end
end


potvec=ones(count,1);
innerVox=ones(count,3);
totLength=count;
count=0;
for i =1:gridSize_wPadding(1)
    for j = 1:gridSize_wPadding(2)
        for k = 1:gridSize_wPadding(3)
            if (voxData(i,j,k,1) ==2)
                count = count+ 1;
                potvec(count) = voxData(i,j,k,3);
                innerVox(count,:) = [i,j,k];
            end
        end
    end
end


maxError=100;
count=0;
prepotVec = potvec;
while (maxError > eps)
    for i =1:totLength
        x = innerVox(i,1);
        y = innerVox(i,2);
        z = innerVox(i,3);
        temp = (voxData(x-1, y, z, 3) + voxData(x+1, y, z, 3)+ ...
               voxData(x, y-1, z, 3) + voxData(x, y+1, z, 3)+...
               voxData(x, y, z-1, 3) + voxData(x, y, z+1, 3))/6;
           
           potvec(i) = temp;
           
           voxData(x,y,z,3) = temp;
           
    end
           diff = prepotVec - potvec;
           maxError =norm(diff,2);
           disp(['Iteration = ' num2str(count)]);
           disp(['Error = ' num2str(maxError)]);
           count=count+1;
           prepotVec = potvec;
end
