function [train test] = dimreduce(trainin, testin, method)
    maxrows = 1000;
    maxcomps = 100;
    maxprecomps = 200;
    
    
    ldata = trainin(randperm(rows(trainin)),:);
    ldata = ldata(1:min(rows(trainin), maxrows), :);
    ldata = datanormalize(ldata);
    ldata(isnan(ldata)) = 0;
    ldata(isinf(ldata)) = 0;
    [c dum k] = princomp(ldata);
    comps = find(cumsum(k)/sum(k) > 0.95, 1);
    comps = min(comps, maxcomps);
    
    if strcmp(which('compute_mapping'), '') ~= 0
        error('Cannot find the dimensionality reduction toolbox')
    end
    
    if strcmp(method, 'NPE') || strcmp(method, 'kmeans')
        [ldata mapping] = compute_mapping(ldata, 'PCA', comps);
        trainin = out_of_sample(trainin, mapping);
        testin = out_of_sample(testin, mapping);
    end
        
        
    if strcmp(method, 'kmeans')
        % icent = zeros(comps, cols(ldata));
        % for i = 1:comps
        %    icent(i,:) = ldata(i,:) + ldata(i + 1,:);
        % end
        % options(14) = 1000;
        % centers = kmeans(icent, ldata, options);
        [pts centers] = kmeans(ldata, comps);
        train = componentize(trainin, centers);
        test = componentize(testin, centers);
    elseif strcmp(method, 'orig')
        train = trainin;
        test = testin;
    else
        [mapped mapping] = compute_mapping(ldata, method, comps);
        if strcmp(method, 'PCA') || strcmp(method, 'KernelPCA') || strcmp(method, 'NPE')
            train = out_of_sample(trainin, mapping);
            test = out_of_sample(testin, mapping);
        else
            train = out_of_sample_est(trainin, mapping.X, mapped);
            test = out_of_sample_est(testin, mapping.X, mapped);
        end
    end
end