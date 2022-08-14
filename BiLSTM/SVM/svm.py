# -*- coding: utf-8 -*-

from sklearn import svm
from sklearn.ensemble import RandomForestClassifier
from sklearn import tree
import numpy as np

from sklearn.ensemble import AdaBoostClassifier
from sklearn.tree import DecisionTreeClassifier

from sklearn.metrics import accuracy_score
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
from sklearn.metrics import f1_score
from sklearn.metrics import roc_auc_score
from sklearn.model_selection import train_test_split as ts
from sklearn import preprocessing

from scipy.io import loadmat

# load data

m = loadmat("train.mat")
X_train = m['XTrain']
y_train = m['YTrain']
X_test = m['XTest']
y_test = m['YTest']

# select different type of kernel function and compare the score

# kernel = 'rbf'
clf_rbf = svm.SVC(C = 0.035, kernel='rbf') # C = 0.035
clf_rbf.fit(X_train,y_train)
score_rbf = clf_rbf.score(X_test,y_test)
print("The score of rbf is : %f"%score_rbf)

## kernel = 'linear'
#clf_linear = svm.SVC(C = 5, kernel='linear')
#clf_linear.fit(X_train,y_train)
#score_linear = clf_linear.score(X_test,y_test)
#print("The score of linear is : %f"%score_linear)
#
## kernel = 'poly'
#clf_poly = svm.SVC(kernel='poly')
#clf_poly.fit(X_train,y_train)
#score_poly = clf_poly.score(X_test,y_test)
#print("The score of poly is : %f"%score_poly)

C1 = clf_rbf.predict(X_test)
#C2 = clf_linear.predict(X_test)
#C3 = clf_poly.predict(X_test)


#rf = RandomForestClassifier(n_estimators = 60, max_leaf_nodes = 50, random_state=1)
#rf.fit(X_train,y_train)
#pre_test = rf.predict(X_test)

#clf = tree.DecisionTreeClassifier(max_depth = 25)
#clf = clf.fit(X_train,y_train)
#pre_test = clf.predict(X_test)

#bdt = AdaBoostClassifier(DecisionTreeClassifier(max_depth=20, min_samples_split=20, min_samples_leaf=5),
#                         algorithm="SAMME",
#                         n_estimators=500, learning_rate=0.8)
#bdt.fit(X_train,y_train)
#pre_test = bdt.predict(X_test)


y_predict = C1
import numpy as np
print('\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n')
print('the number of predited essential proteins:', np.sum(y_predict))
print('the number of essential proteins in YTest:', int(np.sum(y_test)))
precision = precision_score(y_test, y_predict)
recall = recall_score(y_test, y_predict)
f_score = f1_score(y_test, y_predict)
auc_score = roc_auc_score(y_test,y_predict)
acc = accuracy_score(y_test, y_predict)
print('Accuracy:', acc, '\n', 'Precision:', precision, 
      '\n', 'Recall:', recall, '\n', 'F_score:', f_score, '\n', 'AUC:', auc_score)