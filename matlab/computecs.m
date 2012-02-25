function c = computecs(G0, G1, pi0, pi1)
    m = length(G0) - 1;
    c = zeros(m + 2, 1);
    
    for j = 1:m
        r0j = G0(j);
        r1j = G1(j);
        r0jp1 = G0(j + 1);
        r1jp1 = G1(j + 1);
        if r1jp1 - r1j == 0
            c(j + 1) = 0;
        else
            c(j + 1) = (pi1*(r1jp1 - r1j))/(pi0*(r0jp1 - r0j) + pi1*(r1jp1 - r1j));
        end
    end
    c(end) = 1;
end