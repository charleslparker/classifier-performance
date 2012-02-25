function metmat = getmetmat(scores, labels)
    nummet = 2;
    metmat = zeros(cols(scores), nummet);
    for i = 1:cols(scores)
        cscores = scores(:,i);
        [F0 F1] = computeroc(cscores, labels);
        uthresh = length(F0)/length(cscores);
        posclass = sum(labels)/length(labels);
        metmat(i,:) = [uthresh posclass];
    end
end