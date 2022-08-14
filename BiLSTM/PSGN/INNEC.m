clear,clc
load('proteins.mat');
load('PC.mat');
load('SON.mat');

PC = PC / max(PC);

% NSL = NSL / max(NSL);
NSL = mapminmax(NSL', 0, 1)';

AdjcentMatrix = AdjMatrix;
Point = zeros(length(AdjcentMatrix),1);
D = zeros(length(AdjcentMatrix),1);

for i = 1:length(AdjcentMatrix)

    d = find(AdjcentMatrix(i,:) == 1);
    D(i) = length(d);

end


c = zeros(length(AdjcentMatrix),1);
for i = 1:length(AdjcentMatrix)

    d = find(AdjcentMatrix(i,:) == 1);
    C = [];
    for j = 1:length(d)
        
        d1 = find(AdjcentMatrix(d(j),:) == 1);
        e = intersect(d,d1);
        DD = d(j)*ones(length(e),1);
        C = [C;DD, e'];

        
    end    
    C = unique(C,'rows');
    c(i) = size(C,1)/(D(i)*(D(i)));
end

for i = 1:length(AdjcentMatrix)
    
     d = find(AdjcentMatrix(i,:) == 1);
     
     for j = 1:length(d)
        
        d1 = find(AdjcentMatrix(d(j),:) == 1);
        e = intersect(d,d1);
        Point(i) = Point(i) + (length(e))^3*c(d(j))/(D(i)*D(d(j)));
        
     end
     
     
end

Point = mapminmax(Point', 0, 1)';
Point1 = Point .* NSL;

load('NSL-2.mat');
NSL2 = mapminmax(NSL2', 0, 1)';
Point2 = Point .* NSL2;

% load('PCC.mat'); 
% Point1 = zeros(length(AdjcentMatrix),1);
% A = edge(:, 1); B = edge(:, 2);
% for i = 1:length(AdjcentMatrix)
%      d = find(AdjcentMatrix(i,:) == 1);
%      for j = 1:length(d)
%         
%         d1 = find(AdjcentMatrix(d(j),:) == 1);
%         e = intersect(d,d1);
%         a1 = find(A == i); % A, B ÎªPPI±ß¼¯
%         a2 = find(B == d(j));
%         a3 = intersect(a1,a2);
% 
%         
%         if ~isempty(a3)
%             bio = pcc(a3);
%             
%             Point(i) = Point(i) + (length(e) + 1)/min([D(i),D(d(j))])*bio;      
%             Point1(i) =  Point1(i) + (length(e))^3*c(d(j))/(D(i)*D(d(j)))*bio;
% 
%         else
%             a1 = find(B == i);
%             a2 = find(A == d(j));
%             a3 = intersect(a1,a2);  
%             bio = pcc(a3);
%             
%             Point(i) = Point(i) + (length(e) + 1)/min([D(i),D(d(j))])*bio;        
%             Point1(i) =  Point1(i) + (length(e))^3*c(d(j))/(D(i)*D(d(j)))*bio;
% 
%         end
%     end
% 
% end


[B1,I] = sort(Point2, 'descend');
value3 = 0;
for i = 1:600
    t = I(i);
    if essential_list(t) == 1
        value3 = value3 + 1;
    end
end

value3