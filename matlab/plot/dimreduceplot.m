function dimreduceplot(comps, labels)
    cases = getcases(comps, 1);
    reduced = zeros(length(labels), 1);
    totals = repmat(rows(cases), length(labels), 1);
    
    for i = 1:length(labels)
        reduced(i) = sum(cases(:,end) == i);
    end
    
    makebar(reduced, totals, labels, true);
    ylabel('Proportion of cases with minority size = 1', 'FontSize', 14);
end
    
    