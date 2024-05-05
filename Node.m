% A Huffman Tree Code
classdef Node
    properties
        left = []        % left node
        right = []       % right node
        probability = 0  % probability
        symbol           % symbol
        code = ''        % tree direction (0/1)
    end
    
    methods
        % initialize the values of the node
        function obj = Node(probability, symbol, left, right)
            if nargin > 0
                obj.probability = probability;
                obj.symbol = symbol;
                if nargin > 2
                    obj.left = left;
                    obj.right = right;
                end
            end
        end
    end
end
