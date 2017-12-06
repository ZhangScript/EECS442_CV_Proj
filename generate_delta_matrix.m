function [delta_matrix, left_edge_index, right_edge_index, left_blank_max, right_blank_max] = generate_delta_matrix(num_split, subimagename, data_image, ERROR_RATE)
    % build delta matrix
    
    %% initialize the delta matrix
    delta_matrix = zeros(num_split, num_split);
    %% find the most left and right edge
    left_edge_index = 1;
    left_blank_max = 0;
    right_edge_index = 1;
    right_blank_max = 0;
    for j = 1:num_split
        subimg_name = char(subimagename(j));
        left_part = data_image.(subimg_name); % use its right edge
        [row, step_size] = size(left_part);
        
        % find the most left 
        for k = 1:step_size
            if (row - sum(left_part(:, k))) / row > ERROR_RATE
                left_blank_val = k - 1;
                break;
            end
        end
        
        % update the left max
        if (left_blank_val > left_blank_max) || (left_blank_val == step_size)
           left_edge_index = j;
           left_blank_max = left_blank_val;
        end
        
        % find the most right
        for k = 1:step_size
           if (row - sum(left_part(:, step_size + 1 - k))) / row > ERROR_RATE
               right_blank_val = k - 1;
               break;
           end
        end

        % update the right max
        if (right_blank_val > right_blank_max) || (right_blank_val == step_size)
           right_edge_index = j;
           right_blank_max = right_blank_val;
        end
        
        left_part_right_edge = left_part(:,end);
        for k = 1:num_split
            if (j == k)
                continue;
            end
            subimg_name = char(subimagename(k));
            right_part = data_image.(subimg_name); % use its left edge
            right_part_left_edge = right_part(:,1);
            delta_matrix(j, k) = sum(~xor(left_part_right_edge, right_part_left_edge));
        end
    end
end