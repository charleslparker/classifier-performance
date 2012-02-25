function compmat = evalperfmat(perfmat, cinds)
    compmat = [];
    for i = 1:rows(perfmat)
        for j = (i + 1):rows(perfmat)
            p1 = perfmat(i, :);
            p2 = perfmat(j, :);
            compmat = [compmat; [p1 > p2, cinds(i), cinds(j)]];
        end
    end
end