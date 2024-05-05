function OneD_To_2D = From_1D_To_2D(Blocks)
    OneD_To_2D = cell(size(Blocks));
    for i = 1:size(Blocks, 1)
        for j = 1:size(Blocks, 2)
            Block = Blocks{i, j};
            num_of_rows = sqrt(length(Block));
            num_of_cols = sqrt(length(Block));
            new_block = zeros(num_of_rows, num_of_cols);
            % Initial Position (row = 1, col = 1)
            curr_row = 1;
            curr_col = 1;
            % Initialize an upward flag to record the current direction
            upward = true;
            
            for elem_num = 1:num_of_rows*num_of_cols
                % Copy the current element from the 1D vector to the 2D block
                new_block(curr_row, curr_col) = Block(elem_num);
                % Upward Case
                if upward
                    % if the current element is at the last column, the next action
                    % should be move down, and then go diagonally downward
                    if curr_col == num_of_cols
                        curr_row = curr_row + 1;
                        upward = false;
                    % if the current element is at the first row, the next action
                    % should be move to the right, and then go diagonally downward
                    elseif curr_row == 1
                        curr_col = curr_col + 1;
                        upward = false;
                    % if the current element is not at the first row or at the last
                    % column, then move diagonally upward
                    else
                        curr_row = curr_row - 1;
                        curr_col = curr_col + 1;
                    end
                
                % Downward Case
                else
                    % if the current element is at the last row, the next action
                    % should be move right, and then go diagonally upward
                    if curr_row == num_of_rows
                        curr_col = curr_col + 1;
                        upward = true;
                    % if the current element is at the first column, the next action
                    % should be move down, and then go diagonally upward
                    elseif curr_col == 1
                        curr_row = curr_row + 1;
                        upward = true;
                    % if the current element is not at the first column or at the last
                    % row, then move diagonally downward
                    else
                        curr_row = curr_row + 1;
                        curr_col = curr_col - 1;
                    end
                end
            end
        OneD_To_2D{i, j} = new_block;
        end
    end
end