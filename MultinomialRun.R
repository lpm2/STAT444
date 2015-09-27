## First attempt at using a multinomial distribution
## 9/26/2015

require('Matrix')
library('glmnet');
library('nnet');

ratings = read.table("ratings.csv",header=TRUE,sep=",")
idmap = read.table("IDMap.csv",header=TRUE,sep=",")
gender = read.table("gender.csv", header=TRUE,sep=",")

rmat = sparseMatrix(i=ratings[,1],j=ratings[,2],x=ratings[,3])


multi_model = glmnet(as.matrix(ratings[,1:2]), as.matrix(ratings[,3]), family = 'multinomial')
pred = predict(multi_model, as.matrix(idmap[,1:2]))

multi_model2 = multinom(Rating ~ UserID + ProfileID, data = ratings)

response = matrix(data = 0, nrow = dim(ratings)[1], ncol = 10);

for(i in seq(1,dim(ratings)[1])) {
  col = ratings[i, 3]
  response[i, col] = response[i, col] + 1
}

multi_model2 = multinom(response ~ UserID + ProfileID, data = ratings)

model = glmnet(as.matrix(ratings[,1:2]), as.matrix(ratings[,3]), family="multinomial")

prediction = as.data.frame(predict(model, as.matrix(idmap[,1:2]), type="response"))

# multinom(Rating ~ UserID + ProfileID, data=ratings)

response = matrix(rep(0,nrow(ratings)*10), ncol=10)
# apply(response, 1, function(row){row[ratings$Rating]=1})

for(i in 1:nrow(ratings)) {
  response[i, ratings[i, 3]] = 1
}

model2 = glmnet(as.matrix(ratings[,1:2]), as.matrix(response), family="multinomial")
prediction2 = as.data.frame(predict(model2, as.matrix(idmap[,1:2])))

