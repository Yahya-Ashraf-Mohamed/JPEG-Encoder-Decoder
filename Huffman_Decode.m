%% |Huffman Decode|
% |Decode Huffman-encoded data|
% |Input:|
%
% * |*streambits:* Stream of Huffman-encoded bits|
% * |*root:* The root node of the Huffman tree|
%
% |*Outputs:*|
%
% * |*output:* Decoded data|

function decoded_message = Huffman_Decode(streambits, root)
    
    % Initialize variables
    decoded_message = [];
    start = root;

    % Iterate over each symbol in the stream
    for symbol = streambits
        % Convert the symbol to a string and iterate over each digit
        binaryStr = num2str(symbol{1});
        
        for idx = 1:numel(binaryStr)
            bit = binaryStr(idx);
            % Traverse the Huffman tree based on the current bit
            if start.left.code == str2double(bit)
                start = start.left;
            else
                start = start.right;
            end

            % If a leaf node is reached, append the symbol to the decoded_message
            if isempty(start.left) && isempty(start.right)
                decoded_message = [decoded_message, start.symbol];
                start = root;
            end
        end
    end
end