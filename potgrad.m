function dvecdt = potgrad(t,y, voxData, shapecenter)
y_round = round(y);
xVal = y_round(1);
yVal = y_round(2);
zVal = y_round(3);


dist=norm(([xVal, yVal, zVal] - shapecenter),2);
if (dist < 3)
    dvecdt = zeros(3,1);
    
else
    count =1;
    lhsmat = ones(27,8);
    rhsVec = ones(27,1);
    for i = -1:1
        for j =-1:1
            for k =-1:1
            rhsVec(count,1)=voxData(xVal+i, yVal + j, zVal+k, 3);
            lhsmat(count,:)=[(xVal+i)*(yVal+j)*(zVal+k), (xVal+i)*(yVal+j), (yVal+j)*(zVal+k), ...
                              (zVal+k)*(xVal+i), (xVal+i), (yVal+j), (zVal+k), 1];
                          
            count=count+1;
            end
        end
    end
    
    paramVec = (pinv(lhsmat))*rhsVec;
    
    potgradVec(1,1)=(paramVec(1)*y(2)*y(3) + paramVec(2)*y(2) + paramVec(4)*y(3) +paramVec(5));
    potgradVec(2,1)=(paramVec(1)*y(1)*y(3) + paramVec(2)*y(1) + paramVec(3)*y(3) +paramVec(6));
    potgradVec(3,1)=(paramVec(1)*y(1)*y(2) + paramVec(3)*y(2) + paramVec(4)*y(1) +paramVec(7));
    
    gradGain = -1/norm(potgradVec,2);
    dvecdt = gradGain*potgradVec;
 end
