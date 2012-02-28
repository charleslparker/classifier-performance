function M = makeperfmatrix(scores)
    M = zeros(cols(scores) - 1, numperf);
    for i = 1:cols(scores) - 1
        M(i,:) = computeallperf(scores(:,i), scores(:,end));
    end
end