function classifierplot(comps, labels)
    cases = getcases(comps, 1);
    classifier = zeros(length(labels), 1);
    totals = repmat(rows(cases), length(labels), 1);
    
    for i = 1:length(labels)
        classifier(i) = sum(cases(:,end-2) == i - 1 | cases(:,end-3) == i - 1);
    end
    
    makebar(classifier, totals, labels, true);
    ylabel('Proportion of cases with minority size = 1', 'FontSize', 12);
end