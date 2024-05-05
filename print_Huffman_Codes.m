%% |print Huffman Codes|
% |Display Huffman codes|
% |Input:|
%
% * |*Codes:* Huffman codes for symbols (container.Map)|

function print_Huffman_Codes(Codes)
    % Display Huffman codes
    fprintf('\nHuffman Codes:\n');
    
    % Check if the keys are numeric or characters
    keysArray = keys(Codes);
    if isnumeric(keysArray{1})
        for symbol = keys(Codes)
            fprintf('%d: %s\n', symbol{1}, Codes(symbol{1}));
        end
    else
        for symbol = keys(Codes)
            fprintf('%s: %s\n', symbol{1}, Codes(symbol{1}));
        end
    end
end