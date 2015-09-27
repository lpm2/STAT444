ratings = read.table("ratings.csv",header=TRUE,sep=",")
idmap = read.table("IDMap.csv",header=TRUE,sep=",")
gender = read.table("gender.csv", header=TRUE,sep=",")

rmat = sparseMatrix(i=ratings[,1],j=ratings[,2],x=ratings[,3])