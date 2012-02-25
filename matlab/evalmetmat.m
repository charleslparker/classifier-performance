function compmat = evalmetmat(metmat)
    compmat = [];
    for i = 1:rows(metmat)
        for j = (i + 1):rows(metmat)
            p1 = metmat(i, :);
            p2 = metmat(j, :);
            stats = [mean([p1(1) p2(1)]), abs(p1(1) - p2(1)), mean([p1(2) p2(2)])];
            compmat = [compmat; stats];
        end
    end
end