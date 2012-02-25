function perfmat = getperfmat(scores, labels)
    numperf = 7;
    perfmat = zeros(cols(scores), numperf);
    for i = 1:cols(scores)
        cscores = scores(:,i);
        perfmat(i,:) = computeallperf(cscores, labels);
    end
end