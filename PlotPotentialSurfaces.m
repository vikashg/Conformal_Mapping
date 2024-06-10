function PlotPotentialSurfaces(input_file)
readInputFile;
input_file_other_subjs;

streamline_file = strcat(output_dir, 'streamlines.mat');
load(streamline_file);

size_1 = size(voxData);
sx = size_1(1); sy = size_1(2); sz = size_1(3);

all_indices = zeros(sx*sy*sz, 3);

count = 1

for i =1:sx
    for j = 1:sy
        for k = 1:sz
            
            if (voxData(i, j, k, 3) >0.975) & (voxData(i,j,k, 3) < 0.98)
                all_indices(count, :) = [i, j, k];
                count = count + 1;
            end
        end
    end
end
layers = all_indices(1:count-1, :);
plot3(layers(:, 1), layers(:, 2), layers(:, 3), '.')
hold on 
count = 1;
for i =1:sx
    for j = 1:sy
        for k = 1:sz
    
            if (voxData(i, j, k, 3) >0.989) & (voxData(i,j,k, 3) < 0.99)
                all_indices(count, :) = [i, j, k];
                count = count + 1;
            end
        end
    end
end
layers = all_indices(1:count-1, :);
plot3(layers(:, 1), layers(:, 2), layers(:, 3), 'r.')
plot3(boundVox(:, 1), boundVox(:, 2), boundVox(:, 3), 'g.')

%% Plot streamlines
stepSizeStreamLinesPlot=10;
for i = 1:stepSizeStreamLinesPlot:length(streamlines_uniq_resampled)
    a = streamlines_uniq_resampled{i};
    plot3(a(:,1), a(:,2), a(:,3))
end

%% save the streamline potential layer 
output_figure_filename=strcat(output_dir, 'Potential_streamlines.fig');
output_figure_filename
saveas(gcf,output_figure_filename);
close all

