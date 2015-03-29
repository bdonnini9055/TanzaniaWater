import pandas as pa
import numpy as np
from sklearn import tree

# read in training data
train = pa.read_csv('training-values.csv')
#print train[1:15]

temp = pa.read_csv('training-labels.csv')
#print temp[1:15]
train['status_group'] = temp['status_group']


# read in submission data
submission = pa.read_csv('SubmissionFormat.csv')
submission.columns = ['id', 'b']
#print submission[1:15]

#read in test data
test = pa.read_csv('test.csv')
# print test[1:15]


#merge submission format and training data so it stays in the right order
#print submission[1:5]
#print train[1:5]
fTrain = pa.merge(submission, train, left_on='id', right_index=True,
      how='left', sort=False)


#fTrain = train.join(submission, on='id')
print fTrain[1:15]

#recode certain variables
#train[basinNum] = mean(train[status_num][train[basin] == "Internal"]
# train[basinNum][train[basin] == "Lake Nyasa"] <- mean(train[status_num][train[basin] == "Lake Nyasa"])


'''
relevantinput = train[['amount_tsh','gps_height', 'longitude', 'construction_year', 'population']]
trainsample = train[['status_group']]



clf = tree.DecisionTreeClassifier()
clf = clf.fit(relevantinput, trainsample)

reader2ids = test[['id']]
relevantinput2 = test[['amount_tsh','gps_height', 'longitude', 'construction_year', 'population']]

answer = pa.DataFrame(clf.predict(relevantinput2))

answer.to_csv('five-variables-python.csv')
'''