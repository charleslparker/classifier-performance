function lhatbeta = computelhatbeta(cs, G0, G1, pi0, pi1, alph, bet)
    lhatbeta = 0;
    m = length(cs) - 2;
    
    for i = 0:m
        r0i = G0(i + 1);
        r1i = G1(i + 1);
        ci = cs(i + 1);
        cip1 = cs(i + 2);
    
        losspart1 = pi0*(1 - r0i)*(incbeta(cip1, 1 + alph, bet) - incbeta(ci, 1 + alph, bet))/incbeta(1, alph, bet);
        losspart2 = pi1*r1i*(incbeta(cip1, alph, 1 + bet) - incbeta(ci, alph, 1 + bet))/incbeta(1, alph, bet);
        
        lhatbeta = lhatbeta + losspart1 + losspart2;
    end
end