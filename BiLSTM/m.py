# -*- coding: utf-8 -*-

from sklearn.metrics import accuracy_score
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
from sklearn.metrics import f1_score
from sklearn.metrics import roc_auc_score
import numpy as np

from scipy.io import loadmat

m = loadmat("output.mat")
y_predict = m['YPred']
y_test = m['YTest']

print('\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n')
print('the number of predited essential proteins:', np.sum(y_predict))
print('the number of essential proteins in YTest:', np.sum(y_test))
precision = precision_score(y_test, y_predict)
recall = recall_score(y_test, y_predict)
f_score = f1_score(y_test, y_predict)
auc_score = roc_auc_score(y_test,y_predict)
acc = accuracy_score(y_test, y_predict)
print('Accuracy:', acc, '\n', 'Precision:', precision, 
      '\n', 'Recall:', recall, '\n', 'F_score:', f_score, '\n', 'AUC:', auc_score)