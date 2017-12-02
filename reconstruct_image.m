function reconstruct_final = reconstruct_image(num_split, left_edge_index, right_edge_index, delta_matrix, data_image, subimagename)
    % find the reconstruct order
    recons_order = zeros(1, num_split);
    recons_order(1) = left_edge_index;
    recons_order(num_split) = right_edge_index;
    left_idx = 2;
    right_idx = num_split - 1;
    prev_left = left_edge_index;
    prev_right = right_edge_index;
    
    while left_idx < right_idx
        % find the right part according to the right edge of the prev_left
        [~, cur_left] = max(delta_matrix(prev_left, :));
        recons_order(left_idx) = cur_left;
        delta_matrix(: , cur_left) = 0;
        prev_left = cur_left;
        left_idx = left_idx + 1;
        
        % end point
        if (left_idx - 1 == right_idx)
           break; 
        end
        
        [~, cur_right] = max(delta_matrix(:, prev_right));
        recons_order(right_idx) = cur_right;
        delta_matrix(cur_right , :) = 0;
        prev_right = cur_right;
        right_idx = right_idx - 1;
    end
   
    % reconstruct the image
    reconstruct_final = [];
    for k = 1:length(recons_order)
       subimg_name = char(subimagename(recons_order(k)));
       reconstruct_final = [reconstruct_final, data_image.(subimg_name)];
    end
end