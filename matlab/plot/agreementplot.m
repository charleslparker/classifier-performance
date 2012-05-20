function agreementplot(comps, labels)
    cases = getcases(comps, 2);
    agree = zeros(numperf(), numperf());
    totals = repmat(rows(cases), numperf(), numperf());
    labmat = cell(numperf(), numperf());
    sc = sum(cases(:, 1:numperf()), 2);
    sc2 = sc == 2;
    sc5 = sc == 5;
    
    for i = 1:numperf() - 1
        for j = i + 1:numperf()
            caseagree = cases(:,i) == cases(:,j);
            agree(i, j) = sum(caseagree & cases(:,i) == 1 & sc2);
            agree(i, j) = agree(i, j) + sum(caseagree & cases(:,i) == 0 & sc5);
            labmat{i, j} = sprintf('%s == %s', labels{i}, labels{j});
        end
    end
    
    agree = agree(:);
    labmat = labmat(:);
    totals = totals(:);
    
    [vals keys] = sort(agree, 'descend');
    top5 = keys(1:5);
    
    makebar(agree(top5), totals(top5), labmat(top5), true);
    ylabel('Proportion of cases with minority size = 2', 'FontSize', 14);
end