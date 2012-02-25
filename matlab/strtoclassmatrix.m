function mat = strtoclassmatrix(str)
    uvals = unique(str);
    mat = zeros(length(str), length(uvals));
    if iscell(str)
        for i = 1:length(uvals)
            mat(:,i) = strcmp(uvals{i}, str);
        end
    else 
        for i = 1:length(uvals)
            mat(:,i) = (str == uvals(i));
        end
    end
end