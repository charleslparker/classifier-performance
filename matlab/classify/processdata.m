function results = processdata(feat, labs, dimred, clsf)
    folds = 10;
    results = cell(length(dimred), cols(labs));
    r = randperm(rows(feat));
    features = feat(r,:);
    labels = labs(r,:);
    
    if strcmp(which('trainandtest'), '') ~= 0
        error('It looks like WEKALab is not installed or on your path');
    end
    
    for i = 1:length(dimred)
        for j = 1:cols(labels)
            results{i,j} = zeros(rows(labels), length(clsf));
        end
    end
    
    for i = 1:folds
        fprintf('Fold %d...\n', i);
        [trin tstin] = getsplit(features, i, folds);
        [trlabs tstlabs sind eind] = getsplit(labels, i, folds);
        for j = 1:length(dimred)
            fprintf('Reducing dimension: %s\n', dimred{j});
            [train test] = dimreduce(trin, tstin, dimred{j});
            for k = 1:cols(labels)
                fprintf('Learning on label %d\n', k);
                trset = [train trlabs(:,k)];
                tstset = [test tstlabs(:,k)];
                for x = 1:length(clsf)
                    [acc pred] = trainandtest(trset, tstset, clsf(x));
                    results{j, k}(sind:eind,x) = pred(:,2);
                end
            end
        end
    end
    
    for i = 1:length(dimred)
        for j = 1:cols(labels)
            results{i,j} = [results{i,j} labels(:,j)];
        end
    end
                
end