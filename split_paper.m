function data_split_eachimages = split_paper(image, NUM_SPLIT, OutputFolderName,imagename)
    % Split the paper to n*m pieces
    %   
    % Output: data_split_images
    %% pre-processing, set the threshold to binarize the img 
    IMG_THRE = 0.7;
    img = rgb2gray(double(imread(image.name))/255);
    img(img >= IMG_THRE) = 1;
    img(img < IMG_THRE) = 0;
    [row, col] = size(img);
    %% start splitting
    mkdir([OutputFolderName, '/', imagename]); % make output folder for splitted images
    if NUM_SPLIT(1) == 1   % lengthway cut
        numsplit = NUM_SPLIT(2);
        num_random_order = [1:numsplit];
        step_size = ceil(col / numsplit);
        for j = 1:numsplit
            subname=['sub', num2str(j)];
            data_split_eachimages.(subname) = img(:, ((num_random_order(j)-1) * step_size + 1) : min(num_random_order(j) * step_size, col));
            figure (j)
            imshow(data_split_eachimages.(subname));
            figName = [pwd, '/',OutputFolderName, '/', imagename, '/',subname,'.jpg'];
            saveas(figure (j), figName);
            close all;
        end
    else                    % grid cut
        num_random_order = randperm(NUM_SPLIT(1)*NUM_SPLIT(2));
        step_size_row = ceil(row / NUM_SPLIT(1));
        step_size_col = ceil(col / NUM_SPLIT(2));
        count = 1;
        for j = 1:NUM_SPLIT(1)
            for k = 1:NUM_SPLIT(2)
                subname=['sub', num2str(count)];
                row_split = ceil(num_random_order(count)/NUM_SPLIT(2));
                col_split = num_random_order(count) - NUM_SPLIT(2)*(row_split-1);
                data_split_eachimages.(subname) = img(((row_split-1) * step_size_row + 1) : min(row_split * step_size_row, row), ((col_split-1) * step_size_col + 1) : min(col_split * step_size_col, col));
                figure (count)
                imshow(data_split_eachimages.(subname));
                figName = [pwd, '/',OutputFolderName, '/', imagename, '/',subname,'.jpg'];
                saveas(figure (count), figName);
                close all;
                count = count + 1;
            end
        end
    end
end