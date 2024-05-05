function IDCT_OUT = IDCT(Blocks)
    IDCT_OUT = cell(size(Blocks));
    for i = 1:size(Blocks, 1)
        for j = 1:size(Blocks, 2)
            Block = Blocks{i, j};
            [num_of_rows_per_block, num_of_cols_per_block] = size(Block);
            new_block = zeros(size(Block));
            for x = 0:num_of_rows_per_block-1
                for y = 0:num_of_cols_per_block-1
                    sum = 0;
                    for u = 0:num_of_rows_per_block-1
                        for v = 0:num_of_cols_per_block-1
                            sum = sum + Block(u+1, v+1) * ...
                            cos(((2*x+1)*u*pi)/16) * cos(((2*y+1)*v*pi)/16);
                        end
                    end
                    new_block(x+1, y+1) = sum;
                end
            end
            IDCT_OUT{i, j} = new_block;
        end
    end
end