function ap = computeap(scores, labels)
    if cols(scores) == 1 && cols(labels) == 1
        n0 = sum(labels == 0);
        n1 = sum(labels == 1);
        [F0 F1] = computeroc(scores, labels);
        pre = zeros(length(F0), 1);
        rec = zeros(length(F0), 1);
        
        for i = 1:length(F0)
            tp = n1 - F1(i);
            fp = n0 - F0(i);
            fn = F1(i);
        
            pre(i) = tp/(tp + fp);
            rec(i) = tp/(tp + fn);
        end
        
        % remove the degenerate case of zero recall and undefined precision
        % when all points are labeled negative
        pre = pre(1:end-1);
        rec = rec(1:end-1);
        % The most common definition of average precision averages only
        % values occuring after a change in recall
        [d inds] = unique(rec, 'first');
        ap = mean(pre(inds));
    else
        ap = zeros(1, cols(labels));
        for i = 1:cols(labels)
            ap(i) = computeauc(scores(:, i), labels(:, i));
        end
    end
end