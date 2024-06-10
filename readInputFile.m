%fid = fopen('sample_input_file_HCP_train.txt');
fid = fopen(input_file);
input_cell = cell(9,1);
i = 1;
tline = fgetl(fid);
while ischar(tline)
    temp_Cell{i} = tline;
    tline = fgetl(fid);
    i=i+1;
end
input_cell = temp_Cell; 
clear temp_Cell;
