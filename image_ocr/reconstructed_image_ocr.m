%% This example is to contextualize the image using ocr and save it as txt file. 
% Next step is to make it general to deal with all the images. 

%% Read Image from Reconstructed Image folder
addpath 'Output reconstructed images';
list=dir('Output reconstructed images/');

mkdir(['image_ocr_text_files', '\', imagename]); % make output folder for splitted images

for i = 3:1:length(list)
    imagename = list(i).name;
    reconstruct_image = imread(imagename);
    ocrResults = ocr(reconstruct_image);
    recognizedText = ocrResults.Text;
    
    image_raw_name = imagename((end - 3) : end);

%     fid = fopen('test1.txt','wt');
%     fprintf(fid, '%s', recognizedText);
%     fclose(fid);
end




%% This example is to contextualize the image using ocr and save it as txt file. 
% Next step is to make it general to deal with all the images. 

reconstruct_image   = imread('test1.png');
ocrResults     = ocr(reconstruct_image);
recognizedText = ocrResults.Text;

fid = fopen('test1.txt','wt');
fprintf(fid, '%s', recognizedText);
fclose(fid);