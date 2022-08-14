close all
clear, clc
load('SON.mat');
load('PEC.mat');
load('PC.mat');
load('proteins.mat');

load('NSL-2.mat');
load('PC_INNEC.mat');
PC_2 = mapminmax(PC_2', 0, 1)';


% pc = zeros(length(AdjMatrix), 1);
% for i = 1:length(AdjMatrix)
%     
%     s = find(AdjMatrix(i, :) == 1);
%     
%     for j = 1:length(s)
%         pc(i) = pc(i) + PC(s(j));
%     end
%         
% end

ecc = mapminmax(ecc', 0, 1)';
% NSL = mapminmax(NSL', 0, 1)';
PC = PC / max(PC);
PEC = mapminmax(PEC', 0, 1)';


pc = zeros(length(AdjMatrix), 1);
for i = 1:length(AdjMatrix)
    
    s = find(AdjMatrix(i, :) == 1);
    
    for j = 1:length(s)
        pc(i) = ecc(s(j)) * PC(s(j)) + pc(i);
    end
        
end


% Beta = 0.3;
% Alpha = 0.55;
% Sigma = 0.88;

% NN = ((NSL * (1 - Beta) + ecc * Beta) * Alpha + PEC * (1 - Alpha)) * Sigma + PC * (1 - Sigma);

Beta = 0.3;
Alpha = 0.55;
Sigma = 0.88;

NN = ((NSL2 * (1 - Beta) + ecc * Beta) * Alpha + PEC * (1 - Alpha)) * Sigma + PC * (1 - Sigma);

load('data1.mat');
NSL_INNEC = mapminmax(NSL_INNEC', 0, 1)';
PC_INNEC = mapminmax(PC_INNEC', 0, 1)';

load('PCC_INNEC.mat');
PCC_INNEC = mapminmax(PCC_INNEC', 0, 1)';

load('NSL-INNEC2.mat');
NSL_INNEC2 = mapminmax(NSL_INNEC2', 0, 1)';

% max = 0; aa = 0; bb = 0; cc = 0; input = 100;
% for m = 1:20
%     for n = 1:20
%         for k = 1:20
%             a = m / 20; b = n / 20; c = k / 20;
%             
% %             NNN = PEC * a + NSL_INNEC * b + PC_INNEC * (1 - a - b);
% %             NNN = (NSL * (1 - b) + PEC * b) * a + PC * (1 - a);
% %             NNN = PEC * a + NSL * b + ecc * c + PC * (1 - a - b - c);
% 
% %             NNN = ((NSL_INNEC * (1 - b) + ecc * b) * a + PC * (1 - a)) * c + PEC * (1 - c);
% 
% %             NNN = ((PEC * (1 - b) + ecc * b) * a + PC * (1 - a)) * c + NSL_INNEC * (1 - c);
% 
% %             NNN = ((PC * (1 - b) + NSL_INNEC * b) * a + PEC * (1 - a)) * c + ecc * (1 - c);
% 
%             NNN = ((PC + NSL_INNEC) * a + PEC * (1 - a)) * b  + ecc * (1 - b);
% 
% %             NNN = NSL_INNEC * a + b * ecc + c * PC + PEC * (1 - a - b - c);
% 
% 
%             [~,I] = sort(NNN,'descend'); count = 0;
% 
%             for i = 1 : input
% 
%                     t = I(i);
%                     if essential_list(t) == 1
%                         count = count + 1;     
%                     end
% 
%             end
% 
%             if max < count
%                 max = count;
%                 aa = a;
%                 bb = b;
%                 cc = c;
%             end
%         end
%     
%     end
% end


max = 0; aa = 0; bb = 0; cc = 0; input = 100;

% a = 0.49 - 0.0005 * input;
% b = 1 - 0.0003 * input;

a = 0.49 - 0.0005 * input;
b = 1 - 0.0003 * input;

NN = ((PC + NSL_INNEC) * a + PEC * (1 - a)) * b  + ecc * (1 - b);

[~,I] = sort(NN,'descend'); count = 0;
for i = 1 : input

        t = I(i);
        if essential_list(t) == 1
            count = count + 1;     
        end

end

count

Itr = input / 50; result = 0;
for i = 1:Itr
    ins = i * 50;
    
    a = 0.49 - 0.0005 * ins;
    b = 1 - 0.0003 * ins;
    NN = ((PC + NSL_INNEC) * a + PEC * (1 - a)) * b  + ecc * (1 - b);
    [~, I] = sort(NN, 'descend');
    Index = I(1 : ins);
    
    if i == 1
        result = Index;
    else
        List = setdiff(Index, result);
        result = [result; List];
    end
    
end

count = 0;

for i = 1 : length(result)

        t = result(i);
        if essential_list(t) == 1
            count = count + 1;     
        end

end

count

% 
% 
% for m = 1:100
%     for n = 1:100
%         
%             a = m / 100; b = n / 100;
%             
% 
%             NNN = ((PC + NSL_INNEC) * a + PEC * (1 - a)) * b  + ecc * (1 - b);
% 
%             [~,I] = sort(NNN,'descend'); count = 0;
% 
%             for i = 1 : input
% 
%                     t = I(i);
%                     if essential_list(t) == 1
%                         count = count + 1;     
%                     end
% 
%             end
% 
%             if max < count
%                 max = count;
%                 aa = a;
%                 bb = b;
% 
%             end
%     end
% end
% 
% max
% 
% aa
% bb
