import pandas as pd

url="https://raw.githubusercontent.com/wangjk321/Intragenic-cohesin-project/master/March2020/bino161_normalizedContinuous15.matrix"
mt = pd.read_csv(url,sep="\t")
type(mt)

mt.index=mt.CohesinPos
mt.shape
mt.drop("CohesinPos",axis=1,inplace=True)

mt.head()

#1. divide data to (Decreased + Intragenic ) and others.
sum(mt["GeneE2response"]==1)
sum(mt["Mvalue_continue"]>0.5)
sum(mt["Mvalue"]==-1)
sum(mt["cohesin.intra"]==1)

sum((mt["GeneE2response"]==1) & (mt["Mvalue"]==-1) & (mt["cohesin.intra"]==1) )

sum((mt["Mvalue_continue"]<-0.5) & (mt["cohesin.intra"]==1) )
mt.shape

#1. divide data to (Decreased + Intragenic ) and others.
y=(mt["Mvalue_continue"]<-0.5) & (mt["cohesin.intra"]==1)
type(y)

X=mt.drop(["Mvalue","Mvalue_continue","cohesin.TSS","cohesin.TES","cohesin.extraFar","cohesin.extraNear","cohesin.intra"],axis=1)

X.shape
y.shape

from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test = train_test_split(X,y)
X_train.shape
