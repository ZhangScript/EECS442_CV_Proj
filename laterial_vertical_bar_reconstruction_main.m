% laterial and vertical bar reconstruction
% Made on 12/01/2017
clear all; close all; clc;
NUM_SPLIT = [4 5]; % row and colum

load data_split_images.mat;

imagenames = fieldnames(data);
OutputFolderName = 'Output reconstructed images'; 
mkdir(OutputFolderName); % make output folder for splitted images
ERROR_RATE = 0.0729483286; % magic number by dzhang 

for i = 1:length(imagenames)
    img_name = char(imagenames(i));
    
    % calculate the top and bottom distance for each cube subimage
    subimagename = fieldnames(data.(img_name));
    num_split = length(subimagename);    
    
    % function to top and bottom value for each sub images (idx -> val)
    top_blank_val_index = zeros(num_split, 1);
    top_word_val_index = zeros(num_split, 1);
    bottom_blank_val_index = zeros(num_split, 1);
    bottom_word_val_index = zeros(num_split, 1);
    %% construct the previous four matrix
    for j = 1:num_split
        subimg_name = char(subimagename(j));
        image_part = data.(img_name).(subimg_name); % cube image
%         sub_img_row_sum = sum(~image_part,2);
%         plot(sub_img_row_sum)

        %% --------------------------------------------------------------
        % start from here
        [step_size, col] = size(image_part);
        is_word = 0;
        
        
        % ONLY TOP 
        % first identify it belongs to word or blank
        if (col - sum(image_part(1, :))) / col > ERROR_RATE
            is_word = 1;
        end
        
        if (is_word) % is_word 
            for k = 1:step_size
                if (col - sum(image_part(k, :))) / col < ERROR_RATE
                    top_word_val_index(j) = k - 1;
                    break;
                end
            end
        else % is_blank
            % obtain top value
            for k = 1:step_size
                if (col - sum(image_part(k, :))) / col > ERROR_RATE
                    top_blank_val_index(j) = k - 1;
                    break;
                end
            end
        end
        
        
        % ONLY BOTTOM
        
        % first identify it belongs to word or blank
        if (col - sum(image_part(step_size, :))) / col > ERROR_RATE
            is_word = 1;
        else 
            is_word = 0;
        end
        
        if (is_word) % is_word 
            % obtain top value
            for k = 1:step_size
                if (col - sum(image_part(step_size + 1 - k, :))) / col < ERROR_RATE
                    bottom_word_val_index(j) = k - 1;
                    break;
                end
            end
        else % is_blank
            % obtain bottom value
            for k = 1:step_size
                if (col - sum(image_part(step_size + 1 - k, :))) / col > ERROR_RATE
                    bottom_blank_val_index(j) = k - 1;
                    break;
                end
            end
        end
    end
    
    %% find the avg blank value  
    [~, index_sort_top_blank] = sort(top_blank_val_index, 'descend' );
    [~, index_sort_bottom_blank] = sort(bottom_blank_val_index, 'descend' );
    index_top_blank = index_sort_top_blank(1:NUM_SPLIT(2));
    index_bottom_blank = index_sort_bottom_blank(1:NUM_SPLIT(2));
    
    blank_sum = (sum(top_blank_val_index) ...                               % top blank sum 
                + sum(bottom_blank_val_index) ...                           % bottom blank sum
                - (sum(top_blank_val_index(index_top_blank))) ...            % most top sum
                - sum(bottom_blank_val_index(index_bottom_blank)));               % most bottom sum
            
    blank_avg = blank_sum / (length(top_blank_val_index(top_blank_val_index > 0)) - NUM_SPLIT(2));
           
    %% find the avg word value
%     [~, index_sort_top_word] = sort(top_word_val_index, 'descend' );
%     [~, index_sort_bottom_word] = sort(bottom_word_val_index, 'descend' );
%     index_top_word = index_sort_top_word(1:NUM_SPLIT(2));
%     index_bottom_word = index_sort_bottom_word(1:NUM_SPLIT(2));
    
    word_sum = (sum(top_word_val_index) + sum(bottom_word_val_index));
         
    word_avg = word_sum / (length(top_word_val_index(top_word_val_index > 0)));
    
    %% reconstruct the order of matrix
    reconstruct_matrix = zeros(NUM_SPLIT);
    % top and bottom finished here 
    reconstruct_matrix(1, :) = index_top_blank;
    reconstruct_matrix(NUM_SPLIT(1), :) = index_bottom_blank;
    top_blank_val_index(index_top_blank, :) = 0; % top blank should be set 0;
    top_blank_val_index(index_bottom_blank, :) = 0; % bottom blank or word should be set 0;
    top_word_val_index(index_bottom_blank, :) = 0;
    prev_row_index = 1;
    while prev_row_index < NUM_SPLIT(1) - 1
        if mean(bottom_word_val_index(reconstruct_matrix(prev_row_index,:))) < 2 % bottom is blank
            target_top_blank_value = blank_avg - mean(bottom_blank_val_index(reconstruct_matrix(prev_row_index,:)));
            [~, index_target_sort_top_blank] = sort(abs(top_blank_val_index - target_top_blank_value), 'descend' );
            num = 1;
            for  k = 1:length(index_target_sort_top_blank)
               if (top_blank_val_index(index_target_sort_top_blank(k)) > 0 )
                   reconstruct_matrix(prev_row_index + 1, num) = index_target_sort_top_blank(k);
                   top_blank_val_index(index_target_sort_top_blank(k)) = 0;
                   if (num == NUM_SPLIT(2))
                       break;
                   else
                       num = num + 1;
                   end
               end
            end
    %         reconstruct_matrix(prev_row_index + 1, :) = index_target_sort_top_blank(1:NUM_SPLIT(2));

        else                                                                     % bottom is word
            target_top_word_value = word_avg - mean(bottom_word_val_index(reconstruct_matrix(prev_row_index,:)));
            [~, index_target_sort_top_word] = sort(abs(top_word_val_index - target_top_word_value), 'descend' );
            num = 1;
            for  k = 1:length(index_target_sort_top_word)
               if (top_word_val_index(index_target_sort_top_word(k)) > 0 )
                   reconstruct_matrix(prev_row_index + 1, num) = index_target_sort_top_word(k);
                   top_word_val_index(index_target_sort_top_word(k)) = 0;
                   if (num == NUM_SPLIT(2))
                       break;
                   else
                       num = num + 1;
                   end
               end
            end
        end
        prev_row_index = prev_row_index + 1;
    end
    % 
%     new_reconstruct_matrix = [];
%     for j = 1:size(reconstruct_matrix,1)
%         new_reconstruct_matrix_row = [];
%         for k = 1:size(reconstruct_matrix,2)
%             subimg_name = char(subimagename(reconstruct_matrix(j,k)));
%             image_part = data.(img_name).(subimg_name);
%             new_reconstruct_matrix_row = [new_reconstruct_matrix_row, image_part];
%         end
%         new_reconstruct_matrix = [new_reconstruct_matrix; new_reconstruct_matrix_row];
%     end
%     imshow(new_reconstruct_matrix)
    reconstruct_final = [];
    for j = 1:size(reconstruct_matrix,1)
        data_subimg_line = struct;
        for k = 1:size(reconstruct_matrix,2)
            subimg_name = char(subimagename(reconstruct_matrix(j,k)));
            image_part = data.(img_name).(subimg_name);
            data_subimg_line.(subimg_name) = image_part;
        end
        reconstruct_final = [reconstruct_final; vertical_bar_reconstruction(data_subimg_line)];
    end
    figure (i)
    imshow(reconstruct_final);
    img_name_savedname = ['Reconstructed_', img_name];
    figName = [pwd, '/',OutputFolderName,'/', img_name_savedname,'.png'];
    saveas(figure (i), figName);
    close all;
    
    
%     reconstruct_final = vertical_bar_reconstruction(data.(img_name));
%     
%     % Save reconstructed image to output folder
%     figure (i)
%     imshow(reconstruct_final);
%     img_name_savedname = ['Reconstructed_', img_name];
%     figName = [pwd, '\',OutputFolderName,'\', img_name_savedname,'.jpg'];
%     saveas(figure (i), figName);
%     close all;
end