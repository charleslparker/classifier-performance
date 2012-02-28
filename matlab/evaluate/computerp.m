function rp = computerp(scores, labels)
    if cols(scores) == 1 && cols(labels) == 1
        [sc ord] = sort(scores);
        sl = labels(ord);
        n1 = sum(labels == 1);
        
        tp = sum(sl(end-n1+1:end) == 1);
        fp = sum(sl(end-n1+1:end) == 0);
        
        rp = tp/(tp + fp);
    else
        rp = zeros(1, cols(labels));
        for i = 1:cols(labels)
            rp(i) = computerp(scores(:, i), labels(:, i));
        end
    end
end