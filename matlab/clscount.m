function [total mclass] = clscount(comps, clfs)
    total = zeros(length(clfs),1);
    mclass = zeros(length(clfs),1);
    sol = getsolitarycases(comps, 1);
    for i = 1:length(clfs)
        c = clfs(i);
        total(i) = sum(comps(:,8) == c | comps(:,9) == c);
        mclass(i) = sum(sol(:,8) == c | sol(:,9) == c);
    end
end