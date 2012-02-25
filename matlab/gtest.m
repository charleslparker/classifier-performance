function [p gstat] = gtest(vec)
    expect = sum(vec)/length(vec);
    gstat = 2*sum(vec .* log(vec ./ expect));
    p = 1 - chi2cdf(gstat, length(vec));
end