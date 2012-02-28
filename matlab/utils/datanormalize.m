function X = datanormalize(data, mns, stdev)
    if nargin < 2
        mns = repmat(mean(data), rows(data), 1);
    else
        mns = repmat(mns, rows(data), 1);
    end
        
    if nargin < 3
        stdev = repmat(std(data), rows(data), 1);
    else
        stdev = repmat(stdev, rows(data), 1);
    end
    X = (data - mns) ./ stdev;
end