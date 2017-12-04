% Split the images to lengthways
% Made on 12/01/2017

%% Read Image from Input Image folder
addpath 'Input Images';
list=dir('Input Images/');
OutputFolderName = 'Images of splitting result'; 

% pre-processing, set the threshold to binarize the img 
IMG_THRE = 0.7;
%% fixit: list is unkown 
for i = 3:1:length(list)
    imagename = list(i).name;
    imagename(end-3:end) = []; % remove the suffix. e.g, .png
    data.(imagename) = split_paper(list(i), NUM_SPLIT, OutputFolderName, imagename);
end

NAME = 'data_split_images';  %% data_whole_Subs
save(NAME, 'data');