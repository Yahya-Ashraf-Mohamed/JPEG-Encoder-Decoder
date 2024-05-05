%% |Get Encoding|
% |Get Huffman encoding for the input data|
% |Input:|
%
% * |*data (numeric array):* The input data to be encoded|
% * |*Codes (containers.Map):* A map containing symbols as keys and their Huffman 
% codes as values|
%
% |*Outputs:*|
% 
% * |*Encoded_text (cell array):* The Huffman-encoded representation of the 
% input data|

function Encoded_text = GetEncoding(data, Codes)
    % Check if the input data is numeric
    if isnumeric(data)
        % Use arrayfun to apply the Codes map to each element
        Encoded_text = arrayfun(@(item) Codes(item), data, 'UniformOutput', false);
    else
        % Note: our data are just numbers but just in case we needed it
        % For non-numeric data (e.g., strings), use cellfun to apply Codes to each character
        Encoded_text = cellfun(@(item) Codes(item), cellstr(data), 'UniformOutput', false);
        
        % Concatenate the individual codes to form the encoded text        
        Encoded_text = strcat(Encoded_text{:});
    end
end
