function [G0 G1] = computeconvexhull(F0, F1, n0, n1)
    K1 = length(F0);
    
    G0 = 0:(K1 - 1);
    G1 = 0:(K1 - 1);

    i = 1;
    hc = 1;
    
    while i < K1
        c1 = (i + 1):K1;

        for j = (i + 1):K1
            u1 = F1(j) - F1(i);
            u0 = F0(j) - F0(i);
            c1(j) = u1/(u1+u0);
        end
        
        argmin = i + 1;
        c1min = c1(i + 1);
        
        for k = (i + 1):K1
            if c1(k) <= c1min
                argmin = k;
            end
            c1min = c1(argmin);
        end
        hc = hc + 1;
        G0(hc) = F0(argmin);
        G1(hc) = F1(argmin);
        i = argmin;
    end
    
    G0 = G0(1:hc)/n0;
    G1 = G1(1:hc)/n1;
end