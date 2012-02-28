function [hhat cprob] = computeh(scores, labels)
    if cols(scores) == 1 && cols(labels) == 1
        alph = 2;
        bet = 2;
        n0 = sum(labels == 0);
        n1 = sum(labels == 1);
        pi0 = n0/length(labels);
        pi1 = n1/length(labels);

        [F0 F1] = computeroc(scores, labels);
        [G0 G1] = computeconvexhull(F0, F1, n0, n1);
        cost = computecs(G0, G1, pi0, pi1);
        
        aucd1 = [(n0*G0 + n1*G1), 1];
        aucd2 = [1, (n0*G0 + n1*G1)];
        aucf = (aucd1 - aucd2)/length(labels);
        cprob{1} = [cost(2:length(G0)) aucf(2:length(G0))'];
        
        lhatbeta = computelhatbeta(cost, G0, G1, pi0, pi1, alph, bet);
        lmax = pi0*incbeta(pi1, 1 + alph, bet) + pi1*incbeta(1, alph, 1 + bet) - pi1*incbeta(pi1, alph, 1 + bet);
        hhat = 1 - (lhatbeta*incbeta(1, alph, bet))/lmax;
    else
        hhat = zeros(1, cols(labels));
        cprob = cell(1, cols(labels));
        for i = 1:cols(labels)
            [hhat(i) cprob(i)] = computeh(scores(:, i), labels(:, i));
        end
    end
end