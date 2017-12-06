function reconstruct_final = reconstruct_image(num_split, left_edge_index, right_edge_index, delta_matrix, data_image, subimagename)
    % reconstruct the papers output the order of pieces
    
    %% find the reconstruct order
    recons_order = zeros(1, num_split);
    recons_order(1) = left_edge_index;
    recons_order(num_split) = right_edge_index;
    left_idx = 2;
    prev_left = left_edge_index;
    delta_matrix(:, right_edge_index) = 0;
    
    % find the right part according to the right edge of the prev_left
    while left_idx < num_split
        [~, cur_left] = max(delta_matrix(prev_left, :));
        recons_order(left_idx) = cur_left;
        delta_matrix(: , prev_left) = 0;
        prev_left = cur_left;
        left_idx = left_idx + 1;
    end
   
    % reconstruct the paper
    reconstruct_final = [];
    for k = 1:length(recons_order)
       subimg_name = char(subimagename(recons_order(k)));
       reconstruct_final = [reconstruct_final, data_image.(subimg_name)];
    end
end