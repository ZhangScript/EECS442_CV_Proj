%% This example is to contextualize the image using ocr and save it as txt file. 
% Next step is to make it general to deal with all the images. 

reconstruct_image   = imread('test1.png');
ocrResults     = ocr(reconstruct_image);
recognizedText = ocrResults.Text;

fid = fopen('test1.txt','wt');
fprintf(fid, '%s', recognizedText);
fclose(fid);