function Dequant_OUT = Dequantization(Blocks, Quant_Table)
    Dequant_OUT = cell(size(Blocks));
    for i = 1:size(Blocks, 1)
        for j = 1:size(Blocks, 2)
            Block = Blocks{i, j};
            try
                new_block = Block.*Quant_Table;
            catch
                disp(i);
                disp(j);
                disp(Block);
            end
            Dequant_OUT{i, j} = new_block;
        end
    end
end