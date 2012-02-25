function M = countagree(perfmat)
    numperf = 7;
    comps = zeros(numperf);
    for i = 1:numperf
        for j = i+1:numperf
            comps(i,j) = sum(perfmat(:,i) == perfmat(:,j));
            comps(j,i) = comps(i,j);
        end
    end
    % M = comps ./ repmat(sum(comps), rows(comps), 1);
    M = comps;
end