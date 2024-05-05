function DCT_OUT = DCT(Blocks)
    DCT_OUT = cell(size(Blocks));
    for i = 1:size(Blocks, 1)
        for j = 1:size(Blocks, 2)
            Block = Blocks{i, j};
            Block = double(Block);
            [num_of_rows_per_block, num_of_cols_per_block] = size(Block);
            new_block = zeros(size(Block));
            for u = 0:num_of_rows_per_block-1 % 0 > 7
                for v = 0:num_of_cols_per_block-1 % 0 > 7
                    sum = 0;
                    for x = 0:num_of_rows_per_block-1 % 0 > 7
                        for y = 0:num_of_cols_per_block-1 % 0 > 7
                            sum = sum + Block(x+1, y+1) * ...
                            cos(((2*x+1)*u*pi)/16) * cos(((2*y+1)*v*pi)/16);
                        end
                    end
                    if u == 0 && v == 0
                        new_block(u+1, v+1) = sum / 64;
                    elseif u == 0 || v == 0
                        new_block(u+1, v+1) = sum / 32;
                    else
                        new_block(u+1, v+1) = sum / 16;
                    end
                end
            end
            DCT_OUT{i, j} = new_block;
        end
    end
end