function mat = makecompmatrix(narray)
    cind1 = [0,1,3,4,5,6,7,8,14];
    cind2 = [0,1,3,4,5,6,7,-5];
    mat = [];
    
    for i = 1:length(narray)
        fprintf('Processing matrix %d...\n', i);
        scores = narray{i}(:,1:end-1);
        labels = narray{i}(:,end);
        pmat = getperfmat(scores, labels);
        mmat = getmetmat(scores, labels);
        if cols(scores) == 9
            nextmat = [evalperfmat(pmat, cind1) evalmetmat(mmat)];
        elseif cols(scores) == 8
            nextmat = [evalperfmat(pmat, cind2) evalmetmat(mmat)];
        end
        mat = [mat; nextmat];
    end
end