function Run_Length_OUT = run_length(Blocks)    
    Run_Length_OUT = cell(size(Blocks));
    for i = 1:size(Blocks, 1)
        for j = 1:size(Blocks, 2)
            line = Blocks{i, j};
            % Initialize the encoded line
            encoded_line = [];
            % For every element in the original array
            for elem = 1:length(line)
                % If the element is not 0, append it to the encoded line
                if line(elem) ~= 0
                    encoded_line = [encoded_line, line(elem)];
                else
                    % If it is 0, check if it's the first zero or not
                    if length(encoded_line) > 2 && encoded_line(end-1) == 0
                        % If it is not the first zero, increment the last element of the encoded line by 1
                        encoded_line(end) = encoded_line(end) + 1;
                    else
                        % If it is the first zero, append 0 and 1
                        encoded_line = [encoded_line, 0, 1];
                    end
                end
            end
            Run_Length_OUT{i, j} = encoded_line;
        end
    end
end