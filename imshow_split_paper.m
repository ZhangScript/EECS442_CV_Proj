clear all; close all; clc;

load data_split_images.mat;

subimagename = fieldnames(data.test2);
reconstruct_final = [];
for i = 1:4
    reconstruct_final_line = [];
    for j = 1:5
        subimg_name = char(subimagename((i-1)*4+j));
        image_part = data.test2.(subimg_name); % cube image
        image_part = imresize(image_part, [242,189]);
        reconstruct_final_line = [reconstruct_final_line,image_part];
    end
    reconstruct_final = [reconstruct_final; reconstruct_final_line];
end
imshow(reconstruct_final);
