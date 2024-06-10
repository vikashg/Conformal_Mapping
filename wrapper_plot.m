subjs=[12170111 12240219 12312537 12351268 12395685 12463343 12525030 12540186 12595653 12605052 12830673 6616456 6644759 7304803];
 
addpaths;

data_dir='/raid/Data/FiberClustering/complete/'


for i=1:1:length(subjs)
    input_file=strcat(data_dir, string(subjs(i)), '/input_file.txt');
    Plot_TrksBoundVox(input_file);
end

