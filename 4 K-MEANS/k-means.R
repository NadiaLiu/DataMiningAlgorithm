#找出对应类
k_means<-function(data,k){
  n<-nrow(data) #n个数据
  init<-sample(n,size=k) #随机抽样k个数据作为初始簇中心
  center<-data[init,] #簇中心的矩阵
  class<-rep(0,time=n)
  temp<-vector(length=k)
  pd<-TRUE
  
  while(pd==TRUE){
    #计算所有数据到各个簇中心的距离并分配簇
    for(p in 1:n){
      for(q in 1:k){
        temp[q]<-sqrt(sum((data[p,]-center[q,])^2))
      }
      class[p]<-which(temp==min(temp))
    }
    
    #更新簇中心
    center1<-matrix(numeric(0),nrow=0,ncol=k)
    for(j in 1:k){
      p<-which(class==j)
      c<-apply(data[p,],2,mean)
      center1<-rbind(center1,c)
    }
    
    #判断停止条件
    ifelse(identical(center1,center),pd<-FALSE,center<-center1)
  }
  return(class)
}

#画图
pic<-function(data,k){
  center<-k_means(data,k)
  result<-cbind(data,center)
  result<-as.data.frame(result)
  names(result)<-c("x","y","class")
  result$class<-as.factor(result$class)
  
  p1<-which(center==1)
  c1<-apply(data[p1,],2,mean)
  p2<-which(center==2)
  c2<-apply(data[p2,],2,mean)
  c<-rbind(c1,c2)
  c<-as.data.frame(c)

  p<-ggplot(data = result, mapping = aes(x = x, y = y,colour=factor(class)))+geom_point(data = c,aes(x=x,y=y),colour="red", size=3)
  p+geom_point()
}


#main function
x1 <- seq(0,pi,length.out=100)
y1 <- sin(x1) + 0.1*rnorm(100)
x2 <- 1.5+ seq(0,pi,length.out=100)
y2 <- cos(x2) + 0.1*rnorm(100)
data <- data.frame(c(x1,x2),c(y1,y2))
names(data) <- c('x','y')

pic(data,2)
