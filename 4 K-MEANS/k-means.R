#������Դ����
x1 <- seq(0,pi,length.out=100)
y1 <- sin(x1) + 0.1*rnorm(100)
x2 <- 1.5+ seq(0,pi,length.out=100)
y2 <- cos(x2) + 0.1*rnorm(100)
data <- data.frame(c(x1,x2),c(y1,y2))
names(data) <- c('x','y')

#�ҳ���Ӧ��
k_means<-function(data,k){
  n<-nrow(data) #n������
  init<-sample(n,size=k) #�������k��������Ϊ��ʼ������
  center<-data[init,] #�����ĵľ���
  class<-rep(0,time=n)
  temp<-c(length=k)
  pd<-TRUE
  
  while(pd==TRUE){
    #�����������ݵ����������ĵľ��벢�����
    for(p in 1:n){
      for(q in 1:k){
        temp[q]<-sqrt((data[p,1]-data[q,1])^2+(data[p,2]-data[q,2])^2)
      }
      class[p]<-which(temp==min(temp))
    }
    
    #���´�����
    center1<-matrix(numeric(0),nrow=0,ncol=k)
    for(j in 1:k){
      p<-which(class==j)
      c<-apply(data[p,],2,mean)
      center1<-rbind(center1,c)
    }
    
    #�ж�ֹͣ����
    ifelse(identical(center1,center),pd<-FALSE,center<-center1)
  }
  return(class)
}

#��ͼ
pic<-function(data,k){
  center<-k_means(data,k)
  result<-cbind(data,center)
  result<-as.data.frame(result)
  names(result)<-c("x","y","class")
  result$class<-as.factor(result$class)
  p<-ggplot(data = result, mapping = aes(x = x, y = y,colour=factor(class)))
  p + geom_point()
  
}

pic(data,2)