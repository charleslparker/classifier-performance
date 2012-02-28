function cases = getcases(perfmat, minoritysize)
    votes = sum(perfmat(:,1:numperf()), 2);
    selector = votes == minoritysize | votes == (numperf() - minoritysize);
    cases = perfmat(selector, :);
end