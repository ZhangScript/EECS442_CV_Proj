% Main function to reconstruct lengthwat cut paper
% Made on 12/01/2017
%% Preparation
load data_split_images.mat;
imagenames = fieldnames(data);
OutputFolderName = 'Output reconstructed images'; 
mkdir(OutputFolderName); % make output folder for splitted images

%% Run lengthway_reconstruction on each line pieces
for i = 1:length(imagenames)
    img_name = char(imagenames(i));
    
    % run lengthway_reconstruction to get reconstructed order of pieces
    reconstruct_final = lengthway_reconstruction(data.(img_name));
    
    % Save reconstructed image to output folder
    figure (i)
    imshow(reconstruct_final);
    img_name_savedname = ['Reconstructed_', img_name];
    figName = [pwd, '/',OutputFolderName,'/', img_name_savedname,'.png'];
    saveas(figure (i), figName);
    close all;
end