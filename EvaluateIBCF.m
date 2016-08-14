function result=EvaluateIBCF(trainData,testData,num)
  itemMatrix=getItemMatrix(trainData);
  itemSim=getItemsSim(itemMatrix);
  users=trainData(:,1);
  result=zeros(length(users),5);
  for i=1:length(users)
      userid=users(i);
      itemsRec=IBCF(userid,itemMatrix,itemSim,num);
      itemsOrg=testData(testData(:,1)==userid,2:size(testData,2));
      result(i,1)=userid;
      result(i,2:5)=EvaluateParam(itemsRec,itemsOrg);
  end
end
