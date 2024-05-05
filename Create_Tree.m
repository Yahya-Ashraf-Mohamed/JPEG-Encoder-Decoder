%% Create Tree
% |_*This Function Takes A List Of Intial Nodes List(Nodes(class)) Then Iteratively Simulates The Process Of Huffman Coding*_|
% 
% 
% |_*Steps:*_|
% 
% |-> Sort Symbols Based On Probabilities|
% 
% |-> Take Least Two|
% 
% |-> Make a New Node With The Sum Of Two Probs|
% 
% |-> Then Repeat Until There is Only One Node Left In The List With|
% 
% |Prob Equal To 1.|
% 
% 
% |Input:|
% 
% * |*Nodes:* list of nodes|
% |*Returns:*|
%
% * |*root:* generated tree for the symboles|

function root = Create_Tree(Nodes)
    % Create Huffman tree from a list of nodes
    while length(Nodes) > 1
        [~, indices] = sort(arrayfun(@(x) x.probability, Nodes));
        Nodes = Nodes(indices);
        
        % Select two smallest nodes
        Left = Nodes(1);
        Right = Nodes(2);

        Left.code = 0;
        Right.code = 1;

        % Combine the two smallest probabilities to create a new node
        New_Node = Node;
        New_Node.probability = Left.probability + Right.probability;
        New_Node.symbol = strcat(char(Left.symbol), char(Right.symbol));
        New_Node.left = Left;
        New_Node.right = Right;

        % Remove the two smallest nodes
        Nodes = Nodes(3:end);

        % Add the new node
        Nodes = [Nodes, New_Node];
    end
    root = Nodes(1);
end