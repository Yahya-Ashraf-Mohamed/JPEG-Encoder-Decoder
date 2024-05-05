function Quant_OUT = Quantization(Blocks, Quant_Table)
    Quant_OUT = cell(size(Blocks));
    for i = 1:size(Blocks, 1)
        for j = 1:size(Blocks, 2)
            Block = Blocks{i, j};
            new_block = Block./Quant_Table;
            Quant_OUT{i, j} = round(new_block);
        end
    end
end