function  reconstruct_final = lengthway_reconstruction(data_image)
    %% Prepare and set error rate for the reconstruction 
    subimagename = fieldnames(data_image);
    num_split = length(subimagename);
    ERROR_RATE = 0.05;
    
    %% Algorithm step 1: build delta matrix
    [delta_matrix, left_edge_index, right_edge_index, ~, ~] = generate_delta_matrix(num_split, subimagename, data_image, ERROR_RATE);
    
    %% Algorithm step 2: match the edges to conduct reconstruction
    reconstruct_final = reconstruct_image(num_split, left_edge_index, right_edge_index, delta_matrix, data_image, subimagename);
    
end