% vertical bar reconstruction
% Made on 12/01/2017
clear all; close all; clc;
load data_split_images.mat;

imagenames = fieldnames(data);
OutputFolderName = 'Output reconstructed images'; 
mkdir(OutputFolderName); % make output folder for splitted images

for i = 1:length(imagenames)
    img_name = char(imagenames(i));
    
    % run vertical_bar_reconstruction to get reconstructed image
    reconstruct_final = vertical_bar_reconstruction(data.(img_name));
    
    % Save reconstructed image to output folder
    figure (i)
    imshow(reconstruct_final);
    img_name_savedname = ['Reconstructed_', img_name];
    figName = [pwd, '\',OutputFolderName,'\', img_name_savedname,'.jpg'];
    saveas(figure (i), figName);
    close all;
end