function newImage = combineBlocks(image_blocks)
    num_of_rows_per_block = 8;
    num_of_cols_per_block = 8;
    
    [num_of_rows, num_of_cols] = size(image_blocks);
    newImage = zeros(num_of_rows * num_of_rows_per_block, ...
        num_of_cols * num_of_cols_per_block);
    
    for i = 1:num_of_rows
        for j = 1:num_of_cols
            newImage((i - 1) * num_of_rows_per_block + 1 ...
                : i * num_of_rows_per_block, ...
                (j - 1) * num_of_cols_per_block + 1 ...
                : j * num_of_cols_per_block) = image_blocks{i, j};
        end
    end
    newImage = uint8(newImage);
end

