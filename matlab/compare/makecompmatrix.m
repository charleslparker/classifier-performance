function M = makecompmatrix(scores, classifiers, labels, dr)
    posfrac = sum(labels)/length(labels);
    pcols = perfsize;
    perf = makeperfmatrix(scores);
    count = 1;
    
    M = zeros(nchoosek(length(classifiers), 2), pcols);
    
    for i = 1:rows(perf) - 1
        for j = i+1:rows(perf)
            cls = [classifiers(i) classifiers(j)];
            M(count,:) = [perf(i,:) > perf(j,:) cls posfrac dr];  
            count = count + 1;
        end
    end
end