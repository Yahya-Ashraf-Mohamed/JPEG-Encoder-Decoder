function image_blocks = divideImageIntoBlocks(image, square)
    num_of_rows_per_block = 8;
    num_of_cols_per_block = 8;
    [num_of_rows, num_of_cols] = size(image);
    switch square
        case 1 % image > square 2D array
            if (num_of_rows < num_of_cols)
                last_dimension = num_of_rows - ...
                    rem(num_of_rows, num_of_rows_per_block);
            else
                last_dimension = num_of_cols - ...
                    rem(num_of_cols, num_of_cols_per_block);
            end
            image = image(1:last_dimension, 1:last_dimension);
        case 0
            last_dimension_rows = num_of_rows - ...
                rem(num_of_rows, num_of_rows_per_block);
            last_dimension_cols = num_of_cols - ...
                rem(num_of_cols, num_of_cols_per_block);
            image = image(1:last_dimension_rows, 1:last_dimension_cols);
        otherwise
            return;
    end
    
    [num_of_rows, num_of_cols] = size(image);

    % num_of_blocks_rows, and num_of_blocks_cols represent the new number
    % of rows and columns of the image matrix after converting it to blocks
    % of 8x8 elements
    num_of_blocks_rows = num_of_rows / num_of_rows_per_block;
    num_of_blocks_cols = num_of_cols / num_of_cols_per_block;
    
    % Define an array container where each element represent a block of the
    % image
    image_blocks = cell(num_of_blocks_rows, num_of_blocks_cols);
    for i = 1:num_of_blocks_rows
        for j = 1:num_of_blocks_cols
            rows_range = ...
                (i * num_of_rows_per_block) - (num_of_rows_per_block - 1) : ...
                i * num_of_rows_per_block;
            cols_range = ...
                (j * num_of_cols_per_block) - (num_of_cols_per_block - 1) : ...
                j * num_of_cols_per_block;
            image_blocks{i, j} = image(rows_range, cols_range);
        end
    end
end