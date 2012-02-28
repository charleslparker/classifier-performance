function minoritysizeplot(comps)
    total = repmat(rows(comps), 4, 1);
    counts = zeros(4, 1);
    
    for i = 0:3
        counts(i + 1) = rows(getcases(comps, i));
    end
    
    makebar(counts, total, {'0', '1', '2', '3'}, false);

    xlabel('Size of Minority');
    ylabel('Proportion of Total Comparisons');
end