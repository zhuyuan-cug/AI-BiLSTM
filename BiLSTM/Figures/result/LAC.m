function Point = LAC(AdjcentMatrix)    
    Point = zeros(length(AdjcentMatrix),1);

    for i = 1:length(AdjcentMatrix)

        d = find(AdjcentMatrix(i,:) == 1);
        D(i) = length(d);

    end

    for i = 1:length(AdjcentMatrix)

        d = find(AdjcentMatrix(i,:) == 1);
        for j = 1:length(d)

            d1 = find(AdjcentMatrix(d(j),:) == 1); %求邻居节点的所有邻居
            e = intersect(d,d1); %e就是求邻居节点的邻居与所求节点的邻居的交集，即为邻居度
            Point(i) = Point(i) + (length(e))/D(i);  %D(i)为节点i的邻居的个数

        end

    end
end