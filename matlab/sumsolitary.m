function [measures clssum] = sumsolitary(perfmat)
    numperf = 7;
    cases = getsolitarycases(perfmat,1);
    measures = sum(cases(:,1:numperf));%/rows(cases);
    if max(perfmat(:,numperf+2)) == 14
        cind = [0,1,3,4,5,6,7,8,14];
    elseif max(perfmat(:,numperf+2)) == 7
        cind = [0,1,3,4,5,6,7,-5];
    end
    
    clssum = zeros(1, length(cind));
    for i = 1:length(cind)
        clssum(i) = sum(cases(:,7) == cind(i) | cases(:,8) == cind(i));
    end
end