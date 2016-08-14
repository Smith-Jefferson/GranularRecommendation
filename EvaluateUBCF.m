function result=EvaluateUBCF(trainData,testData,num)
  SIM = SIMMatrix(trainData);
  users=trainData(:,1);
  Apha=0.4;
  for i=1:length(users)
      userid=users(i);
      itemsRec=UBCF(userid,trainData,SIM,num,Apha);
      itemsOrg=testData(find(testData==userid),2);
      Param=EvaluateParam(itemsRec,itemsOrg);
  end
end
