function  reconstruct_final = vertical_bar_reconstruction(data_image)
    %% Preparition
    subimagename = fieldnames(data_image);
    num_split = length(subimagename);
    ERROR_RATE = 0.05;
    
    %% algorithm step 1: build delta matrix
    [delta_matrix, left_edge_index, right_edge_index, ~, ~] = generate_delta_matrix(num_split, subimagename, data_image, ERROR_RATE);
    
    %% algorithm step 2: reconstruct the image
    reconstruct_final = reconstruct_image(num_split, left_edge_index, right_edge_index, delta_matrix, data_image, subimagename);
end