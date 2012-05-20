function M = classifyalldata(data, classifiers, dimred)
    M = cell(1,cols(data));
    save results_temp M;
    for i = 1:cols(data)
        feat = data{2,i};
        labs = data{3,i};
        dred = dimred;
        
        if cols(feat) > 500
            dred(strcmp(dred, 'orig')) = [];
        end
        
        fprintf('************************* Processing %s...\n', data{1,i})
        M{i} = processdata(feat, labs, dred, classifiers);
        save results_temp M;
    end
end