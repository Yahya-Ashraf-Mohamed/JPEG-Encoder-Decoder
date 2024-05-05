%% Get Codes
% |_*Recursively traverse the Huffman tree to get Huffman codes for each symbol*_|
% |Input:|
%
% * |*node (Node):* the Root node in the Huffman tree|
% * |*value (string):* The current Huffman code|
%
% |*Outputs:*|
%
% * |*codes (containers.Map):* The Huffman codes for each symbol| 

function codes = GetCodes(node, value)

    % If value is not provided, initialize it as an empty string
    if nargin < 2
        value = '';
    end
    
    % Append the current node's code to the existing value
    newVal = strcat(value, num2str(node.code));
    
    % Recursively process the left subtree
    if ~isempty(node.left)
        codes = GetCodes(node.left, newVal);
    else
        % If the node is a leaf, create a map with the symbol and its code
        codes = containers.Map(node.symbol, newVal);
    end
    
    % Recursively process the right subtree
    if ~isempty(node.right)
        rightCodes = GetCodes(node.right, newVal);

        % Combine the codes from left and right subtrees
        codes = [codes; rightCodes];
    end
end