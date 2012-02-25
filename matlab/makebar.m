function makebar(comp1, comp2, leglabs)
    % c1vec = sumsolitary(comp1)';
    % X = (1:7)';
    X = (1:9)';
    % [c1 r1] = wilson(c1vec, sum(c1vec));
    [c1 r1] = wilson(comp1, comp2);
    
    if nargin > 2
        c2vec = sumsolitary(comp2)';
        [c2 r2] = wilson(c2vec, sum(c2vec));
        Y = [c1vec/sum(c1vec) c2vec/sum(c2vec)];
        L = Y - [r1(:,1) r2(:,1)];
        U = [r1(:,2) r2(:,2)] - Y;
        ycolor = ['c', 'r'];
        ecolor = ['k', 'k'];
    else
        % Y = c1vec/sum(c1vec);
        Y = comp1./comp2;
        L = Y - r1(:,1);
        U = r1(:,2) - Y;
        ycolor = 'c';
        ecolor = 'k';
    end
    
    % labels = {'MCC', 'F1-Measure', 'r-Precision', 'H-Measure', 'AUC', 'Average Precision', 'AUK'};
    labels = {'Naive Bayes', 'Logistic Regression', 'SVM-Linear', 'SVM-Gaussian', '10-Nearest Neighbor', 'Decision Tree', 'Adaboost-Tree', 'Adaboost-Stump', '1-Nearest Neighbor'};
    bs = barerror(X, Y, L, U, 1, ycolor, ecolor);
    xticklabel_rotate(X, 45, labels);
    % ylabel('Proportion of Total Error Cases');
    ylabel('Ratio of Error Cases to Total Cases');
    if nargin > 2
        legend(bs, leglabs, 'location', 'northwest');
    end
end