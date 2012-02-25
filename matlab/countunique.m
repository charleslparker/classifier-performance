function [ucount uvals] = countunique(perfmat)
    clsvec = [perfmat(:,end-1) perfmat(:,end)];
    uvals = unique(perfmat);
    ucount = zeros(length(uvals));
    ucount(1, :) = uvals;
    for i = 1:length(uvals)
        for j = 1:length(uvals)
            ucount(i, j) = rows(clsvec(clsvec(:,1) == uvals(i) & clsvec(:,2) == uvals(j))) + rows(clsvec(clsvec(:,1) == uvals(j) & clsvec(:,2) == uvals(i)));
        end
    end
end