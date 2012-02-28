function makebar(trials, totals, labels, leglabs)
    colors = ['c', 'r', 'y', 'm', 'g', 'w', 'k'];
    
    X = (1:rows(trials))';
    Y = trials ./ totals;
    L = zeros(size(Y));
    U = zeros(size(Y));
    ecolor = repmat('k', 1, cols(trials));
    ycolor = colors(1:cols(trials));
    
    for i = 1:cols(trials)
        [c bounds] = wilson(trials(:,i), totals(:,i));
        L(:,i) = Y(:,i) - bounds(:,1);
        U(:,i) = bounds(:,2) - Y(:,i);
    end
    
    size(X)
    size(Y)
    size(L)
    size(U)
    
    bs = barerror(X, Y, L, U, 1, ycolor, ecolor);
    xticklabel_rotate(X, 45, labels);

    if nargin > 3
        legend(bs, leglabs, 'location', 'northwest');
    end
end