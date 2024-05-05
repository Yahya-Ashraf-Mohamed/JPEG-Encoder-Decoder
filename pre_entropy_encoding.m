function vector = pre_entropy_encoding(Blocks)
    vector = [];
    delimeter = -200;
    vector = [size(Blocks, 1) delimeter size(Blocks, 2) delimeter];
    for i = 1:size(Blocks, 1)
        for j = 1:size(Blocks, 2)
            vector = [vector Blocks{i,j} delimeter];
        end
    end
end