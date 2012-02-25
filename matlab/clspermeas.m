function [total mclass] = clspermeas(comps, clfs)
    total = zeros(length(clfs),1);
    mclass = zeros(length(clfs),7);
    sol = getsolitarycases(comps, 1);
    for i = 1:length(clfs)
        c = clfs(i);
        total(i) = sum(sol(:,8) == c | sol(:,9) == c);
        clsol = sol(sol(:,8) == c | sol(:,9) == c,:);
        mclass(i,:) = sum(clsol(:,1:7));
    end
end