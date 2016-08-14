function result=EvaluateGranular(trainData,testData,num)
  %格式化数据%dataFormat();%用户分组%%1.构建用户偏好矩阵%matrix=userPrefrence(data);
  %%2.粗糙聚类
  %用户相似度
  SIM  = SIMMatrix(trainData);
  cluster = RoughCluster( SIM );
  %%3.类的基因（偏好）
  clusterGene=produceClusterGene(cluster,matrix);
  %根据类获取候选集合
  %%需要推荐的用户
  users=trainData(:,1);
  result=zeros(length(users),5);
  for i=1:length(users)
      userid=users(i);
      candidateSet=getCandidateSet(userid,matrix,cluster,clusterGene);
      itemsRec=recommendation(userid,matrix,candidateSet,num,true);
      itemsOrg=testData(find(testData==userid),2);
      result(i,1)=userid;
      result(i,2:5)=EvaluateParam(itemsRec,itemsOrg);
  end
end
