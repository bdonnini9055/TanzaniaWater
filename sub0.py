import pandas as pa
import numpy as np
from sklearn import tree

reader1 = pa.read_csv('/home/drey/Desktop/wells/merged.csv')

relevantinput = reader1[['amount_tsh','gps_height']]
trainsample = reader1[['status_group']]

clf = tree.DecisionTreeClassifier()
clf = clf.fit(relevantinput, trainsample)

reader2 = pa.read_csv('/home/drey/Desktop/wells/testset.csv')

reader2ids = reader2[['id']]
relevantinput2 = reader2[['amount_tsh','gps_height']]

answer = pa.DataFrame(clf.predict(relevantinput2))

answer.to_csv('/home/drey/Desktop/wells/sub0.csv')
