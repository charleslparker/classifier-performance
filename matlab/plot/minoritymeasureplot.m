function minoritymeasureplot(comps)
    names = {'MCC', 'F1-Measure', 'r-Precision', 'H-Measure', 'AUC', 'Average Precision', 'AUK'};
    cases = getcases(comps, 1);
    vote = sum(cases(:,1:numperf()), 2);
    disagreements = zeros(numperf(), 1);
    totals = repmat(rows(cases), numperf(), 1);
    
    for i = 1:numperf()
        mvote = cases(:,i);
        dupvote =  sum(vote == numperf() - 1 & ~mvote);
        ddownvote = sum(vote == 1 & mvote);
        disagreements(i) = dupvote + ddownvote;
    end
    
    makebar(disagreements, totals, names, true);
    ylabel('Proportion of cases with minority size = 1')
end