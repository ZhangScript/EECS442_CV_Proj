% Main function to split the images based on grid cut
% Made on 12/01/2017

%% Read Image from Input Image folder
addpath 'Input Images';
list = dir('Input Images/');
OutputFolderName = 'Images of splitting result'; 

%% Call split_paper function to conduct splitting
for i = 3:1:length(list)
    imagename = list(i).name;
    imagename(end-3:end) = []; % remove the suffix. e.g, .png
    data.(imagename) = split_paper(list(i), NUM_SPLIT, OutputFolderName, imagename);
end

%% Save the data to data_split_images
NAME = 'data_split_images'; 
save(NAME, 'data');