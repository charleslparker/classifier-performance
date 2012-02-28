function M = makeallcomp(scores)
    scoresize = size(scores{1}{1,1});
    cls = 0:scoresize(2) - 2;
    blocksize = nchoosek(length(cls), 2);
    estsize = 0;
    
    
    for i = 1:length(scores)
        sz = size(scores{i});
        estsize = estsize + sz(1)*sz(2)*blocksize;
    end
    
    M = zeros(estsize, perfsize());
    count = 1;
    
    for i = 1:length(scores)
        fprintf('Processing dataset %d...\n', i);
        isc = scores{i};
        for j = 1:rows(isc)
            for k = 1:cols(isc)
                scs = isc{j, k};
                comp = makecompmatrix(scs, cls, scs(:,end), j);
                M(count:count + blocksize - 1,:) = comp;
                count = count + blocksize;
            end
        end
    end
end