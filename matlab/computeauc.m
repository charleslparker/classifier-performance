function auc = computeauc(features, labels)
    if cols(features) == 1 && cols(labels) == 1
        n0 = sum(labels == 0);
        n1 = sum(labels == 1);
        [F0 F1] = computeroc(features, labels);
        auc = trapz(F1/n1, F0/n0);
    else
        auc = zeros(1, cols(labels));
        for i = 1:cols(labels)
            auc(i) = computeauc(features(:, i), labels(:, i));
        end
    end
end