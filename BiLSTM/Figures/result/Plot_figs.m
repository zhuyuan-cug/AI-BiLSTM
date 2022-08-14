close all
clear,clc

load('E:\Research\SGC\code\WDC.mat')
load('proteins.mat')

%% count 

% [~, I] = sort(PEC, 'descend');
% count = 0;
% 
% for i = 1 : 600
%     
%         t = I(i);
%         if essential_list(t) == 1
%             count = count + 1;     
%         end
% 
% end
% 
% count

%% PR curves and Jackknife curve

order = randperm(5093);
PEC = PEC(order);
essential_list = essential_list(order);

Point = PEC;

count = 0;
count1 = 0;
TP6 = [];
Re6 = [];
Ree1 = [];
TPP1 = [];
EL = 0;
[B2,I1] = sort(Point,'descend');
for i = 1 : length(Point)

    t = I1(i);
    if essential_list(t) == 1
        count1 = count1 + 1;     
    end
        
end
EL = count1;
count1 = 0;
for i = 1 : length(Point)
    
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

figure(1)
plot(rec,pre)
set(gca,'YLim',[0 1]);%Y轴的数据显示范围
auprc
%%  Jackknife
X_label = [1:600];
Y_label = [];
value = 0;
[B2,I1] = sort(Point,'descend');
for i = 1:600
    t = I1(i);
    if essential_list(t) == 1
        value = value + 1;
    end
    Y_label(i) = value;
end
figure(2)
plot(X_label,Y_label) 

%% Score


% A = [61
% 120
% 165
% 218
% 263
% 318
% 363
% 405
% 448
% 490
% 536
% 573
% ];
% 
% 
% 
% 
% C = [100
% 200
% 300
% 400
% 500
% 600
% 700
% 800
% 900
% 1000
% 1100
% 1200
% ];
% 
% TP = A;
% FP = C - A;
% 
% 
% TPFN = 1209;
% TNFP = 3770;
% TN = TNFP - FP;
% FN = TPFN - TP;
% SN = TP./TPFN
% SP = TN./TNFP
% NPV = TN./(TN+FN)
% PPV = TP./(TP+FP)
% 
% F = 2*SN.*PPV./(SN+PPV)
% ACC = (TP+TN)./(TPFN+TNFP)

