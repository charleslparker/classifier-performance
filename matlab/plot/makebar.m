function makebar(trials, totals, labels, rotate, leglabs)
    X = (1:rows(trials))';
    Y = trials ./ totals;
    L = zeros(size(Y));
    U = zeros(size(Y));
    
    for i = 1:cols(trials)
        [c bounds] = wilson(trials(:,i), totals(:,i));
        L(:,i) = Y(:,i) - bounds(:,1);
        U(:,i) = bounds(:,2) - Y(:,i);
    end
    
    bs = barerror(X, Y, L, U, 1, rotate, labels);
    
    if rotate
        xticklabel_rotate(X, 45, labels);
    end

    if nargin > 4
        legend(bs, leglabs, 'location', 'northwest');
    end
end