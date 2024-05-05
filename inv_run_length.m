function Run_Length_OUT = inv_run_length(Blocks)
    Run_Length_OUT = cell(size(Blocks));
    for i = 1:size(Blocks, 1)
        for j = 1:size(Blocks, 2)
            % Perform the run length decoding on a line (array) of numbers
            encoded_line = Blocks{i, j};
            % Initialize the decoded line
            decoded_line = [];
            
            % For every element in the encoded array
            for elem = 1:length(encoded_line)
                % If the previous element is zero, skip as this number represents the repeated values of zero
                if elem > 1 && encoded_line(elem-1) == 0
                    continue;
                end
                
                % If the element is not 0, append it to the original line
                if encoded_line(elem) ~= 0
                    decoded_line = [decoded_line, encoded_line(elem)];
                else
                    % If it is 0, repeat the 0 next element of the encoded line times and append all of these 0s to the original line
                    decoded_line = [decoded_line, zeros(1, encoded_line(elem+1))];
                end
            end
            Run_Length_OUT{i, j} = decoded_line;
        end
    end
end