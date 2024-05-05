%% Get Probs
% |Calculate frequencies of elements in the data|
% |Input:|
% 
% * |*data (numeric array):* The input data for which probabilities are calculated|
% 
% |*Outputs:*|
% 
% * |*symbols (containers.Map):* A map containing unique elements as keys and 
% their frequencies as values|

function symbols = GetProbs(data)

     % Check if the input data is numeric
    if isnumeric(data)
        % Use accumarray to calculate frequencies
        [unique_elements, ~, freq] = unique(data);
        symbols = containers.Map(unique_elements, accumarray(freq, 1));
    else
        % Note: our data are just numbers but just in case we needed it
        % For non-numeric data (e.g., strings), use a loop to count frequencies
        symbols = containers.Map;
        for char = data
            if ~isKey(symbols, char)
                symbols(char) = 1;
            else
                symbols(char) = symbols(char) + 1;
            end
        end
    end
end