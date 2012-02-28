function clsmat = multitobinary(vec)
    uvec = unique(vec);
    clsmat = zeros(length(vec), length(uvec));
    for i = 1:length(uvec)
        clsmat(:,i) = vec == uvec(i);
    end
end