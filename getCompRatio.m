function compRatio = getCompRatio(encoded_data, num_of_rows, num_of_cols)
    number_of_bits = 0;
    for i = 1:length(encoded_data)
        number_of_bits = number_of_bits + length(encoded_data{i});
    end
    compRatio = 1 - (number_of_bits / (num_of_rows*num_of_cols*8));
end