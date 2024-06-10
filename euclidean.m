function [euclid3D] = euclidean(p, c)
%Error check
[rp cp] = size(p);
[rc cc] = size(c);
if(rp~=rc)
    usage()
    error('Point arrays must be of equal size');
end
if(cc~=3 || cp~=3)
    usage()
    error('Must be 3D point sets');
end
%Calculate 3D distance between two 3D point sets
euclid3D = zeros(size(p,1),1);
for i=1:size(p,1)
    euclid3D(i,:) = sqrt((c(i,1)-p(i,1))^2+(c(i,2)-p(i,2))^2+(c(i,3)-p(i,3))^2);
end
%Clear variables
clearvars -except 'euclid3D' 'p' 'c';

