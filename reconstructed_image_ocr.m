%% Read Image from Reconstructed Image folder
addpath 'Output reconstructed images';
list=dir('Output reconstructed images/');

image_ocr_output_folder = 'image_ocr_text_files';
mkdir(image_ocr_output_folder);     % make output folder for splitted images

for i = 3:1:length(list)
    imagename = list(i).name;
    reconstruct_image = imread(imagename);
    ocrResults = ocr(reconstruct_image);
    recognizedText = ocrResults.Text;
    imagename(end-3:end) = [];  % remove suffix i.e. png
    figName = [pwd, '/',image_ocr_output_folder, '/', imagename,'.txt'];
    fid = fopen(figName,'wt');
    fprintf(fid, '%s', recognizedText);
    fclose(fid);
end
