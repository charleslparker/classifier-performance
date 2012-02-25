function newarray = scoresfromcells(cellarray, classes)
    newarray = cell(cols(classes), 1);
    for i = 1:cols(classes)
        scores = zeros(rows(classes), length(cellarray));
        for j = 1:length(cellarray)
            cscores = cellarray{j};
            scores(:,j) = cscores(:,i);
        end
        newarray{i} = [scores classes(:,i)];
    end
end