clear,clc
load('features_5.mat')
load('net.mat') 
%% �ز���

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
%����LSTM����ܹ���
%�������Сָ��Ϊ���д�С 12���������ݵ�ά�ȣ�
%ָ������ 100 ��������Ԫ��˫�� LSTM �㣬��������е����һ��Ԫ�ء�
%ָ���Ÿ��࣬������СΪ 9 ��ȫ���Ӳ㣬��� softmax ��ͷ���㡣
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
%ָ��ѵ��ѡ�
%�����Ϊ 'adam'
%�ݶ���ֵΪ 1���������Ϊ 100��
% 27 ��ΪС��������
%���������ʹ�������������ͬ�����г���ָ��Ϊ 'longest'��
%���ݱ��ְ����г��������״̬�����������ݡ�
% 'ExecutionEnvironment' ָ��Ϊ 'cpu'���趨Ϊ'auto'����ʹ��GPU��
maxEpochs = 800;
miniBatchSize = 1000;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','auto', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle','never', ... % �Ƿ����˳��
    'Verbose',0, ...
    'Plots','training-progress');
 
%%
%ѵ��LSTM����
net = trainNetwork(XTrain,YTrain,layers,options);
 
%%
%����LSTM����
%���ز��Լ�

 
%ʹ��classify���з��ָ࣬��С������С27��ָ���������ݰ�������������
miniBatchSize = 100;
YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');
%�������׼ȷ��
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