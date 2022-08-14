clear,clc
load('features_5.mat')
load('net.mat') 
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
x_train = cell(length(list_train), 1);
for i = 1:length(list_train)
    j = list_train(i);
    x_train{i, 1} = XTrain{j, 1};
    y_train(i) = YTrain(j);
end

XTrain = x_train; YTrain = y_train;
YTrain = categorical(YTrain); YTest = categorical(YTest);
%%
%定义LSTM网络架构：
%将输入大小指定为序列大小 12（输入数据的维度）
%指定具有 100 个隐含单元的双向 LSTM 层，并输出序列的最后一个元素。
%指定九个类，包含大小为 9 的全连接层，后跟 softmax 层和分类层。
inputSize = 5;
% numHiddenUnits = 72;
numClasses = 2;
% layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(72,'OutputMode','last')
%     dropoutLayer(0.05)
%     bilstmLayer(24,'OutputMode','last')
%     dropoutLayer(0.05)
%     bilstmLayer(6,'OutputMode','last')
%     fullyConnectedLayer(numClasses)
%     softmaxLayer 
% %     weightedClassificationLayer([0.8 0.2])
%      classificationLayer
% ]

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(36,'OutputMode','last')
    dropoutLayer(0.5)
    bilstmLayer(18,'OutputMode','last')
    dropoutLayer(0.5)
    fullyConnectedLayer(9)
    fullyConnectedLayer(numClasses)
    softmaxLayer 
    classificationLayer
]
%%
%指定训练选项：
%求解器为 'adam'
%梯度阈值为 1，最大轮数为 100。
% 27 作为小批量数。
%填充数据以使长度与最长序列相同，序列长度指定为 'longest'。
%数据保持按序列长度排序的状态，不打乱数据。
% 'ExecutionEnvironment' 指定为 'cpu'，设定为'auto'表明使用GPU。
maxEpochs = 800;
miniBatchSize = 1000;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','auto', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle','never', ... % 是否打乱顺序
    'Verbose',0, ...
    'Plots','training-progress');
 
%%
%训练LSTM网络
net = trainNetwork(XTrain,YTrain,layers,options);
 
%%
%测试LSTM网络
%加载测试集

 
%使用classify进行分类，指定小批量大小27，指定组内数据按照最长的数据填充
miniBatchSize = 100;
YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');
%计算分类准确度
acc = sum(YPred == YTest)./numel(YTest)

YPred = cellstr(YPred); YPred = cell2mat(YPred); YPred = str2num(YPred); sum(YPred)
YTest = cellstr(YTest); YTest = cell2mat(YTest); YTest = str2num(YTest); sum(YTest)

num = 0;
for i = 1:length(YPred)
    
    if YTest(i) == 1
        if YPred(i) == 1
            
            num = num + 1;
            
        end
    end
end
num

% save YPred.txt YPred -ascii; save YTest.txt YTest -ascii;