function print_encoded_data(encoded_data)
    if iscell(encoded_data)
        for i = 1:numel(encoded_data)
            fprintf('%s', encoded_data{i});
        end
    else
        fprintf('%s', mat2str(encoded_data));
    end
end