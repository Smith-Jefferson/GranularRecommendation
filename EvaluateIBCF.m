function result=EvaluateIBCF(trainData,testData,num)
  itemMatrix=getItemMatrix(trainData);
  itemSim=getItemsSim(itemMatrix);
  users=trainData(:,1);
  for i=1:length(users)
      userid=users(i);
      recItems=IBCF(userid,itemMatrix,itemSim,num);
      itemsOrg=testData(find(testData==userid),2);
      Param=EvaluateParam(itemsRec,itemsOrg);
  end
end
