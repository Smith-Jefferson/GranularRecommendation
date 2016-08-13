%格式化数据
dataFormat();
%用户分组
%%1.构建用户偏好矩阵
matrix=userPrefrence(data);
%%2.粗糙聚类
SIM  = SIMMatrix( matrix );%用户相似度
cluster = RoughCluster( SIM );
%%3.类的基因（偏好）
clusterGene=produceClusterGene(cluster,matrix);
%根据类获取候选集合
%%需要推荐的用户
users=matrix(:,1);
userid=users(1);
candidateSet=getCandidateSet(userid,matrix,cluster,clusterGene);
recommendItems=recommendation(userid,matrix,candidateSet,10,true);




            
            
            
        
    
