function mat = componentize(data, centers)
    mat = zeros(rows(data), rows(centers));
    for i = 1:rows(data)
        for j = 1:rows(centers)
            mat(i, j) = norm(data(i,:) - centers(j,:));
        end
    end
    mat = datanormalize(mat);
end