close all
clear, clc

% load('PEC.mat')
load('E:\Research\SGC\code\WDC.mat')
% load('SGC.mat') % 计算600的排序结果
% load('SGC_RANK.mat') % 对600进行抽取的结果

load('proteins.mat')


%% PeC and WDC
[~,I] = sort(PEC,'descend'); count = 0;
input = 600;
for i = 1 : input

        t = I(i);
        if essential_list(t) == 1
            count = count + 1;     
        end

end

count

%% DC-BC-CC-EC-PageRank-LAC

% G = graph(AdjMatrix);
% 
% % DC = centrality(G, 'degree'); % 'degree'-DC, 'betweenness' -BC, 'closeness'-CC, 'eigenvector'-EC, 'pagerank'
% DC = LAC(AdjMatrix);
% 
% [~,I] = sort(DC,'descend'); count = 0;
% input = 600;
% for i = 1 : input
% 
%         t = I(i);
%         if essential_list(t) == 1
%             count = count + 1;     
%         end
% 
% end
% 
% count

%% Jackknife

% X_label = 1:600;
% Y_label = zeros(1, 600);
% value = 0;
% 
% 
% [~,I1] = sort(PEC, 'descend');
% % I1 = result;
% 
% % G = graph(AdjMatrix);
% % DC = centrality(G, 'pagerank'); % 'degree'-DC, 'betweenness' -BC, 'closeness'-CC, 'eigenvector'-EC, 'pagerank'
% % DC = LAC(AdjMatrix);
% % [~,I1] = sort(DC, 'descend');
% 
% for i = 1:600
%     t = I1(i);
%     if essential_list(t) == 1
%         value = value + 1;
%     end
%     Y_label(i) = value;
% end
% figure(1)
% plot(X_label,Y_label)

%% PR-curve

count = 0;
count1 = 0;
TP6 = [];
Re6 = [];
Ree1 = [];
TPP1 = [];
EL = 0;

[~,I1] = sort(PEC, 'descend');
% I1 = result;

% G = graph(AdjMatrix);
% DC = centrality(G, 'pagerank'); % 'degree'-DC, 'betweenness' -BC, 'closeness'-CC, 'eigenvector'-EC, 'pagerank'
% DC = LAC(AdjMatrix);
% [~,I1] = sort(DC, 'descend');

for i = 1 : length(I1)
    t = I1(i);
    if essential_list(t) == 1
        count1 = count1 + 1;     
    end
        
end
EL = count1;
count1 = 0;
for i = 1 : length(I1)
    
    t = I1(i);
    if essential_list(t) == 1
        count1 = count1 + 1;
        m = count1/i;
        TP6 = [TP6,m];
        m = count1/EL;
        Re6 = [Re6,m];          
        Ree1 = [Ree1, i];
        TPP1 = [TPP1,count1];         
        
    end
        
end

global rec;
global pre;
global x;
global y;
rec = [Re6];
pre = [TP6];

x = [Ree1];
y = [TPP1];

auprc = [];
for c = 1
    auprc(c) = 0.5*pre(c,1)*rec(c,1);
    for i=2:length(pre(c,:))
        auprc(c) = auprc(c)+0.5*(pre(c,i)+pre(c,i-1))*(rec(c,i)-rec(c,i-1));
    end
end

figure(2)
plot(rec,pre)
set(gca,'YLim',[0 1]);%Y轴的数据显示范围

auprc

%% accuracy - sensitive - specificity - precision - recall - F-measure

% close all
% 
% SGC_score = [90; 157; 218; 278; 338; 380];
% BC_score = [44; 77; 112; 145; 117; 220];
% CC_score = [41; 79; 117; 153; 189; 228];
% DC_score = [46; 82; 115; 158; 201; 251];
% EC_score = [37; 77; 119; 148; 192; 221];
% LAC_score = [59; 120; 176; 228; 266; 306];
% PageRank_score = [47; 113; 153; 196; 189; 242];
% PeC_score = [76; 143; 203; 245; 292; 331];
% WDC_score = [69; 133; 190; 246; 297; 340];
% 
% % A = CC_score;
% % C = [100; 200; 300; 400; 500; 600];
% % TP = A;
% % FP = C - A;
% TPFN = 1167;
% TNFP = 3926;
% % TN = TNFP - FP;
% % FN = TPFN - TP;
% % 
% % SN = TP./TPFN % sensitive
% % SP = TN./TNFP % specificity
% % NPV = TN./(TN+FN) % 
% % PPV = TP./(TP+FP) % precision
% % 
% % F = 2*SN.*PPV./(SN+PPV) % F-measure
% % ACC = (TP+TN)./(TPFN+TNFP) % accuracy
% 
%         
% A = WDC_score; C = [100; 200; 300; 400; 500; 600];
% len = 'WDC';
% 
% 
% TP = A; FP = C - A; TN = TNFP - FP; FN = TPFN - TP;
% SN = TP./TPFN; SP = TN./TNFP; PPV = TP./(TP+FP); F = 2*SN.*PPV./(SN+PPV); ACC = (TP+TN)./(TPFN+TNFP);
% 
% subplot(1, 5, 1); 
% 
% plot(100:100:600, SN); ylabel('Sensitive'); legend(len); hold on
% 
% subplot(1, 5, 2); 
% 
% plot(100:100:600, SP); ylabel('Specificity'); legend(len); hold on
% 
% subplot(1, 5, 3); 
% plot(100:100:600, PPV); ylabel('Precision'); legend(len); hold on
% 
% subplot(1, 5, 4); 
% plot(100:100:600, F); ylabel('F-measure'); legend(len); hold on
% 
% subplot(1, 5, 5); 
% plot(100:100:600, ACC); ylabel('Accuracy'); legend(len); hold on
%         
