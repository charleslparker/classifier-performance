function [F0 F1] = computeroc(scores, labels)
    [sc ord] = sort(scores);
    sc = [labels(ord) sc];

    n0n1 = length(sc);
    F0 = 0:n0n1;
    F1 = 0:n0n1;
    
    K1 = 1;
    k = 2;
        
    sc = [sc; sc(end,:)];

    for i = 1:n0n1
        F0(k) = F0(K1) + (1 - sc(i,1));
        F1(k) = F1(K1) + sc(i, 1);
        K1 = k;
        if sc(i + 1, 2) ~= sc(i, 2)
            k = k + 1;
        end
    end
    
    F0 = F0(1:K1);
    F1 = F1(1:K1);
end