function Blocks = post_entropy_encoding(vector, num_of_rows, num_of_cols)
    delimeter = -200;
    Blocks = cell(num_of_rows, num_of_cols);
    Indicies_of_Delimeter = find(vector == delimeter);
    All_Starts = [1, Indicies_of_Delimeter + 1];
    All_Ends = [Indicies_of_Delimeter - 1, length(vector)];
    for i = 1:length(All_Starts)
        row = ceil(i / num_of_cols);
        col = mod(i - 1, num_of_cols) + 1;
        Blocks{row, col} = vector(All_Starts(i):All_Ends(i));
    end
end
