function mincase = getsolitarycases(perfmat, n)
    numperf = 7;
    perf = perfmat(:,1:numperf);
    agree = sum(perf, 2);
    consensus = repmat(agree > 3, 1, cols(perf));
    inminority = perf ~= consensus;
    mincase = [inminority perfmat(:,numperf+1:end)];
    maj = agree == n | agree == numperf - n;
    mincase = mincase(maj,:);
end