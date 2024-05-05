%% |Encode Huffman|
% |Encode the input data using Huffman coding|
% |Input:|
%
% * |*data (numeric array):* The input data to be encoded|
% 
% |*Outputs:*|
%
% * |*node:* The root node of the Huffman tree|
% * |*Encoded_Text:* The Huffman-encoded representation of the input data|
% * |*Codes:* A map containing symbols as keys and their Huffman codes as values|

function [node, Encoded_Text, Codes] = encode_Huffman(data)
    
    % Check if the input data is provided
    if nargin < 2
        % If not provided, calculate symbol frequencies from the data
        symbols = GetProbs(data);
    end

    % Create nodes for each symbol
    keysArray = cell2mat(keys(symbols).');
    valuesArray = cell2mat(values(symbols).');
    
    Nodes = arrayfun(@(idx) Node(valuesArray(idx), keysArray(idx)), 1:length(keysArray));
    
    % Build Huffman tree
    node = Create_Tree(Nodes);

    % Get Huffman codes
    Codes = GetCodes(node);

    % Get encoded text
    Encoded_Text = GetEncoding(data, Codes);
end