function Point = LAC(AdjcentMatrix)    
    Point = zeros(length(AdjcentMatrix),1);

    for i = 1:length(AdjcentMatrix)

        d = find(AdjcentMatrix(i,:) == 1);
        D(i) = length(d);

    end

    for i = 1:length(AdjcentMatrix)

        d = find(AdjcentMatrix(i,:) == 1);
        for j = 1:length(d)

            d1 = find(AdjcentMatrix(d(j),:) == 1); %���ھӽڵ�������ھ�
            e = intersect(d,d1); %e�������ھӽڵ���ھ�������ڵ���ھӵĽ�������Ϊ�ھӶ�
            Point(i) = Point(i) + (length(e))/D(i);  %D(i)Ϊ�ڵ�i���ھӵĸ���

        end

    end
end