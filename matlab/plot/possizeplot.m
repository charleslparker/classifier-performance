function possizeplot(comps, labels)
    medpos = median(comps(:,end-1));
    biglab = sprintf('Positive Class > %2.2f%%', medpos*100);
    smalllab = sprintf('Positive Class <= %2.2f%%', medpos*100);
    
    leg = {biglab, smalllab};
    
    cases = getcases(comps, 1);
    abvcases = cases(cases(:,end-1) > medpos,:);
    blwcases = cases(cases(:,end-1) <= medpos,:);
    
    abvvote = sum(abvcases(:,1:numperf()), 2);
    blwvote = sum(blwcases(:,1:numperf()), 2);
    
    disagreements = zeros(numperf(), 2);
    totals = repmat([rows(abvcases) rows(blwcases)], numperf(), 1);
    
    for i = 1:numperf()
        abvmvote = abvcases(:,i);
        abvupvote =  sum(abvvote == numperf() - 1 & ~abvmvote);
        abvdownvote = sum(abvvote == 1 & abvmvote);

        blwmvote = blwcases(:,i);
        blwupvote =  sum(blwvote == numperf() - 1 & ~blwmvote);
        blwdownvote = sum(blwvote == 1 & blwmvote);

        disagreements(i,1) = abvupvote + abvdownvote;
        disagreements(i,2) = blwupvote + blwdownvote;
    end
    
    makebar(disagreements, totals, labels, true, leg);
    ylabel('Proportion of cases with minority size = 1', 'FontSize', 14)
end