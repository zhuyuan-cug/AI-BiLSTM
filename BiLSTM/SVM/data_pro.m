clear,clc

load('data.mat')

x = zeros(5093, 4);

for i = 1:5093
    
    x(i, 1) = ecc(i);
    x(i, 2) = NSL_INNEC(i);
    x(i, 3) = PC(i);
    x(i, 4) = PEC(i);

end

y = essential_list;

%% 划分数据集

a= randperm(5093);
YTrain = zeros(4074, 1);
XTrain = zeros(4074, 4);
for i = 1:4074
    j = a(i);
    XTrain(i, :) = x(j, :);
    YTrain(i) = y(j);
end

YTest = zeros(1019, 1);
XTest = zeros(1019, 4);
for i = 4075:5093
   j = a(i);
   XTest(i - 4074, :) = x(j, :);
   YTest(i - 4074) = y(j);
end

% YTrain = categorical(YTrain); YTest = categorical(YTest);
%% 重采样

f = find(YTrain == 1)';
x_list = 1:length(YTrain);
xx = setdiff(x_list, f);

len = length(xx) + 3 * length(f);
list_train = [xx, f, f, f];

randIndex = randperm(length(list_train));
list_train = list_train(randIndex);
    
randIndex = randperm(length(list_train));
list_train = list_train(randIndex);

randIndex = randperm(length(list_train));
list_train = list_train(randIndex);

y_train = zeros(length(list_train), 1);
for i = 1:length(list_train)
    j = list_train(i);
    x_train(i, :) = XTrain(j, :);
    y_train(i) = YTrain(j);
end

XTrain = x_train; YTrain = y_train;
% YTrain = categorical(YTrain); YTest = categorical(YTest);

save train_data.txt train_data -ascii; save valid_data.txt valid_data -ascii;