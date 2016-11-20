function [result,statistic]=EvaluateUBCF(trainData,testData,num,Apha)
  if(exist('UBCF_SIM.mat','file')>0)
        SIM=cell2mat(struct2cell(load('UBCF_SIM.mat')));
  else
    SIM = SIMMatrix(trainData);
    save  UBCF_SIM.mat SIM;
 end
  users=trainData(:,1);
  users(1)=[];
  numNeighor=30;
  result=zeros(length(users),6);
  for i=1:length(users)
      userid=users(i);
      itemsOrg=testData(testData(:,1)==userid,2:size(testData,2));
      [itemsRec,mae,compare]=UBCF(userid,trainData,SIM,num,Apha,numNeighor,itemsOrg);
      THRESHOLD=getTHRESHOLDFromPreference(getPreferenceItems(userid,trainData(2:size(trainData,1),:)));
      result(i,:)=[userid,mae,EvaluateParam(itemsRec,itemsOrg,THRESHOLD),compare.radio];
      statistic{i}=compare;
  end
end
