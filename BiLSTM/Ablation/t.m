clear; clc
load('data.mat')
load('net.mat')

%% ����feature

% G = graph(AdjMatrix);
% % plot(G)
% 
% X = cell(5093, 1);
% for i = 1:5093
%     
%     n = neighbors(G, i);
%     
% %     f = zeros(4, length(n) + 1);
% %     f(1, 1) = ecc(i);
% %     f(2, 1) = PC(i);
% %     f(3, 1) = NSL_INNEC(i);
% %     f(4, 1) = PEC(i);
% 
%     f(1, 1) = PEC(i);
%     f(2, 1) = NSL_INNEC(i);
%     f(3, 1) = PC(i);
%     
%     for j = 1:length(n)
%         f(1, j + 1) = PEC(i);
%         f(2, j + 2) = NSL_INNEC(i);
%         f(3, j + 1) = PC(i);
% 
%     end
%     
%     X{i} = f;
%     
% end
% 
% Y = essential_list;

%% ����features, distance = 1

G = graph(AdjMatrix);
% plot(G)

X = cell(5093, 1);
for i = 1:5093
    
    n = neighbors(G, i);
    
%     f = zeros(4, length(n) + 1);
%     f(1, 1) = ecc(i);
%     f(2, 1) = PC(i);
%     f(3, 1) = NSL_INNEC(i);
%     f(4, 1) = PEC(i);

    f(1, 1) = PEC(i);
    f(2, 1) = NSL_INNEC(i);
    f(3, 1) = PC(i);
    f(4, 1) = PEC(i);
    f(5, 1) = 0;
    
    for j = 1:length(n)
        f(1, j + 1) = PEC(n(j));
        f(2, j + 2) = NSL_INNEC(n(j));
        f(3, j + 1) = PC(n(j));
        f(4, j + 1) = PEC(n(j));
        f(5, j + 1) = 1;

    end
    
    X{i} = f;
    
end

Y = essential_list;

%% ����features, distance = 2

% G = graph(AdjMatrix);
% % plot(G)
% 
% X = cell(5093, 1);
% for i = 1:5093
%     
%     n = neighbors(G, i);
%     
% %     f = zeros(4, length(n) + 1);
% %     f(1, 1) = ecc(i);
% %     f(2, 1) = PC(i);
% %     f(3, 1) = NSL_INNEC(i);
% %     f(4, 1) = PEC(i);
% 
%     f(1, 1) = PEC(i);
%     f(2, 1) = NSL_INNEC(i);
%     f(3, 1) = PC(i);
%     f(4, 1) = PEC(i);
%     f(5, 1) = 0;
%     
%     for j = 1:length(n)
%         
%         f(1, j + 1) = PEC(n(j));
%         f(2, j + 2) = NSL_INNEC(n(j));
%         f(3, j + 1) = PC(n(j));
%         f(4, j + 1) = PEC(n(j));
%         f(5, j + 1) = 1;
% 
%     end
%     
%     nn = nearest(G, i, 2);
%     nn = setdiff(nn, n);
%     for j = 1:length(nn)
%         
%         f(1, j + 1) = PEC(nn(j));
%         f(2, j + 2) = NSL_INNEC(nn(j));
%         f(3, j + 1) = PC(nn(j));
%         f(4, j + 1) = PEC(nn(j));
%         f(5, j + 1) = 2;
% 
%     end
%     
%     X{i} = f;
%     
% end
% 
% Y = essential_list;

%% ����train & test

a= randperm(5093);
YTrain = zeros(4074, 1);
YTest = zeros(1019, 1);
XTrain = cell(4074, 1);
XTest = cell(1019, 1);

for i = 1:4074
    j = a(i);
    XTrain{i, 1} = X{j};
    YTrain(i) = Y(j);
end

for i = 4075:5093
   j = a(i);
   XTest{i - 4074, 1} = X{j};
   YTest(i - 4074) = Y(j);
end

% YTrain = categorical(YTrain); YTest = categorical(YTest);

