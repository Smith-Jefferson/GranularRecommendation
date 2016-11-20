function [result,compare]=EvaluateIBCF(trainData,testData,num)
  if(exist('IBCF_itemSim.mat','file')>0)
      itemMatrix=cell2mat(struct2cell(load('IBCF_itemMatrix.mat')));
      itemSim=cell2mat(struct2cell(load('IBCF_itemSim.mat')));
  else
      itemMatrix=getItemMatrix(trainData);
      itemSim=getItemsSimByEuclidean(itemMatrix);
      save  IBCF_itemMatrix.mat itemMatrix;
      save  IBCF_itemSim.mat itemSim;
  end
  users=trainData(2:size(trainData,1),1)';
  result=zeros(length(users),6);
  for i=1:length(users)
      userid=users(i);
      itemsOrg=testData(testData(:,1)==userid,2:size(testData,2));
      [itemsRec,mae,compare]=IBCF(i,itemMatrix,itemSim,num,itemsOrg);
      THRESHOLD=getTHRESHOLDFromMatrix(i,itemMatrix);
      result(i,:)=[userid,mae,EvaluateParam(itemsRec,itemsOrg,THRESHOLD),compare.radio];
  end
end
