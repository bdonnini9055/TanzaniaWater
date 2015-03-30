import pandas as pd
import numpy as np
from sklearn import tree
import random
import sys

# read in training data
trainingValues = pd.read_csv('training-values.csv')
#print train[1:15]

trainingLabels = pd.read_csv('training-labels.csv')
#print temp[1:15]
#train['status_group'] = temp['status_group']


# read in submission data
#submission = pd.read_csv('SubmissionFormat.csv')
#submission.columns = ['id', 'b']
#print submission[1:15]

#read in test data
test = pd.read_csv('test_set.csv')
# print test[1:15]


#merge submission format and training data so it stays in the right order
#print submission[1:5]
#print train[1:5]

fTrain = pd.merge(trainingValues, trainingLabels, on='id')
#, right_index=True, how='right', sort=False

#fTrain = train.join(submission, on='id')
#print fTrain[1:15]

#recode certain variables
#train[basinNum] = mean(train[status_num][train[basin] == "Internal"]
# train[basinNum][train[basin] == "Lake Nyasa"] <- mean(train[status_num][train[basin] == "Lake Nyasa"])

# Get numeric values for word columns

# For status_group in training
fTrain['numStatus'] = fTrain['status_group']
fTrain['numStatus'][fTrain['numStatus'] == 'functional'] = 2
fTrain['numStatus'][fTrain['numStatus'] == 'functional needs repair'] = 1
fTrain['numStatus'][fTrain['numStatus'] == 'non functional'] = 0

fTrain['numStatus'] = fTrain['numStatus'].astype(float)

'''
# For Installer
groupedByInstaller = fTrain.groupby('installer', as_index=False).aggregate(np.mean)
installerNum = groupedByInstaller[['installer','numStatus']]
installerZip = zip(installerNum['installer'], installerNum['numStatus'])
installerDict ={key: value for (key, value) in installerZip}
fTrain['numInstaller'] = fTrain['installer']
newInstallerDict = {'numInstaller': installerDict}
fTrain = fTrain.replace(to_replace=newInstallerDict)

# For Funder
groupedByFunder = fTrain.groupby('funder', as_index=False).aggregate(np.mean)
funderNum = groupedByFunder[['funder','numStatus']]
funderZip = zip(funderNum['funder'], funderNum['numStatus'])
funderDict ={key: value for (key, value) in funderZip}
fTrain['numFunder'] = fTrain['funder']
newFunderDict = {'numFunder': funderDict}
fTrain = fTrain.replace(to_replace=newFunderDict)

# For wpt_name
groupedByWpt_name = fTrain.groupby('wpt_name', as_index=False).aggregate(np.mean)
wpt_nameNum = groupedByWpt_name[['wpt_name','numStatus']]
wpt_nameZip = zip(wpt_nameNum['wpt_name'], wpt_nameNum['numStatus'])
wpt_nameDict ={key: value for (key, value) in wpt_nameZip}
fTrain['numWpt_name'] = fTrain['wpt_name']
newWpt_nameDict = {'numWpt_name': wpt_nameDict}
fTrain = fTrain.replace(to_replace=newWpt_nameDict)

#For Basin
groupedByBasin = fTrain.groupby('basin', as_index=False).aggregate(np.mean)
basinNum = groupedByBasin[['basin','numStatus']]
basinZip = zip(basinNum['basin'], basinNum['numStatus'])
basinDict ={key: value for (key, value) in basinZip}
fTrain['numBasin'] = fTrain['basin']
newBasinDict = {'numBasin': basinDict}
fTrain = fTrain.replace(to_replace=newBasinDict)

# For Subvillage
groupedBySubvillage = fTrain.groupby('subvillage', as_index=False).aggregate(np.mean)
subvillageNum = groupedBySubvillage[['subvillage','numStatus']]
subvillageZip = zip(subvillageNum['subvillage'], subvillageNum['numStatus'])
subvillageDict ={key: value for (key, value) in subvillageZip}
fTrain['numSubvillage'] = fTrain['subvillage']
newSubvillageDict = {'numSubvillage': subvillageDict}
fTrain = fTrain.replace(to_replace=newSubvillageDict)

# For Region
groupedByRegion = fTrain.groupby('region', as_index=False).aggregate(np.mean)
regionNum = groupedByRegion[['region','numStatus']]
regionZip = zip(regionNum['region'], regionNum['numStatus'])
regionDict ={key: value for (key, value) in regionZip}
fTrain['numRegion'] = fTrain['region']
newRegionDict = {'numRegion': regionDict}
fTrain = fTrain.replace(to_replace=newRegionDict)

# For District Code
groupedByDistrict_code = fTrain.groupby('district_code', as_index=False).aggregate(np.mean)
district_codeNum = groupedByDistrict_code[['district_code','numStatus']]
district_codeZip = zip(district_codeNum['district_code'], district_codeNum['numStatus'])
district_codeDict ={key: value for (key, value) in district_codeZip}
fTrain['numDistrict_code'] = fTrain['district_code']
newDistrict_codeDict = {'numDistrict_code': district_codeDict}
fTrain = fTrain.replace(to_replace=newDistrict_codeDict)

# For lga
groupedByLga = fTrain.groupby('lga', as_index=False).aggregate(np.mean)
lgaNum = groupedByLga[['lga','numStatus']]
lgaZip = zip(lgaNum['lga'], lgaNum['numStatus'])
lgaDict ={key: value for (key, value) in lgaZip}
fTrain['numLga'] = fTrain['lga']
newLgaDict = {'numLga': lgaDict}
fTrain = fTrain.replace(to_replace=newLgaDict)

# For Ward
groupedByWard = fTrain.groupby('ward', as_index=False).aggregate(np.mean)
wardNum = groupedByWard[['ward','numStatus']]
wardZip = zip(wardNum['ward'], wardNum['numStatus'])
wardDict ={key: value for (key, value) in wardZip}
fTrain['numWard'] = fTrain['ward']
newWardDict = {'numWard': wardDict}
fTrain = fTrain.replace(to_replace=newWardDict)

#For scheme management
groupedByScheme_management = fTrain.groupby('scheme_management', as_index=False).aggregate(np.mean)
scheme_managementNum = groupedByScheme_management[['scheme_management','numStatus']]
scheme_managementZip = zip(scheme_managementNum['scheme_management'], scheme_managementNum['numStatus'])
scheme_managementDict ={key: value for (key, value) in scheme_managementZip}
fTrain['numScheme_management'] = fTrain['scheme_management']
newScheme_managementDict = {'numScheme_management': scheme_managementDict}
fTrain = fTrain.replace(to_replace=newScheme_managementDict)
'''
#For extraction type in training data
groupedByExtraction_type = fTrain.groupby('extraction_type', as_index=False).aggregate(np.mean)
extraction_typeNum = groupedByExtraction_type[['extraction_type','numStatus']]
extraction_typeZip = zip(extraction_typeNum['extraction_type'], extraction_typeNum['numStatus'])
extraction_typeDict ={key: value for (key, value) in extraction_typeZip}
fTrain['numExtraction_type'] = fTrain['extraction_type']
newExtraction_typeDict = {'numExtraction_type': extraction_typeDict}
fTrain = fTrain.replace(to_replace=newExtraction_typeDict)

test['numExtraction_type'] = test['extraction_type']
test = test.replace(to_replace=newExtraction_typeDict)

'''
# For Payment Type
groupedByPayment_type = fTrain.groupby('payment_type', as_index=False).aggregate(np.mean)
payment_typeNum = groupedByPayment_type[['payment_type','numStatus']]
payment_typeZip = zip(payment_typeNum['payment_type'], payment_typeNum['numStatus'])
payment_typeDict ={key: value for (key, value) in payment_typeZip}
fTrain['numPayment_type'] = fTrain['payment_type']
newPayment_typeDict = {'numPayment_type': payment_typeDict}
fTrain = fTrain.replace(to_replace=newPayment_typeDict)

# For Water Quality
groupedByWater_quality = fTrain.groupby('water_quality', as_index=False).aggregate(np.mean)
water_qualityNum = groupedByWater_quality[['water_quality','numStatus']]
water_qualityZip = zip(water_qualityNum['water_quality'], water_qualityNum['numStatus'])
water_qualityDict ={key: value for (key, value) in water_qualityZip}
fTrain['numWater_quality'] = fTrain['water_quality']
newWater_qualityDict = {'numWater_quality': water_qualityDict}
fTrain = fTrain.replace(to_replace=newWater_qualityDict)

#For Quantity
groupedByQuantity = fTrain.groupby('quantity', as_index=False).aggregate(np.mean)
quantityNum = groupedByQuantity[['quantity','numStatus']]
quantityZip = zip(quantityNum['quantity'], quantityNum['numStatus'])
quantityDict ={key: value for (key, value) in quantityZip}
fTrain['numQuantity'] = fTrain['quantity']
newQuantityDict = {'numQuantity': quantityDict}
fTrain = fTrain.replace(to_replace=newQuantityDict)

# For Source
groupedBySource = fTrain.groupby('source', as_index=False).aggregate(np.mean)
sourceNum = groupedBySource[['source','numStatus']]
sourceZip = zip(sourceNum['source'], sourceNum['numStatus'])
sourceDict ={key: value for (key, value) in sourceZip}
fTrain['numSource'] = fTrain['source']
newSourceDict = {'numSource': sourceDict}
fTrain = fTrain.replace(to_replace=newSourceDict)

# For Waterpoint Type

groupedByWaterpoint_type = fTrain.groupby('waterpoint_type', as_index=False).aggregate(np.mean)
waterpoint_typeNum = groupedByWaterpoint_type[['waterpoint_type','numStatus']]
waterpoint_typeZip = zip(waterpoint_typeNum['waterpoint_type'], waterpoint_typeNum['numStatus'])
waterpoint_typeDict ={key: value for (key, value) in waterpoint_typeZip}
fTrain['numWaterpoint_type'] = fTrain['waterpoint_type']
newWaterpoint_typeDict = {'numWaterpoint_type': waterpoint_typeDict}
fTrain = fTrain.replace(to_replace=newWaterpoint_typeDict)

#print fTrain[1:15]

'''

relevantinput = fTrain[['numExtraction_type','population']]
trainsample = fTrain[['status_group']]



clf = tree.DecisionTreeClassifier()
clf = clf.fit(relevantinput, trainsample)

#reader2ids = test[['id']]
#relevantinput2 = test[['amount_tsh','gps_height', 'longitude', 'construction_year', 'population']]

answer = pd.DataFrame(clf.predict(test[['numExtraction_type', 'population']]))
#answer = answer.append(test['id'])
answer.to_csv('march-twenty-nine-numExtraction-type-and-population.csv')

'''
#split data

#Get a random sample of 60% of the data
sixty = .6*len(fTrain.index)
#print sixty #sixty = 35640

rows = random.sample(fTrain.index, 35640)

train_60 = fTrain.ix[rows]

train_40 = fTrain.drop(rows)
'''