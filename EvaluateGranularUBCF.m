function [result,statistic]=EvaluateGranularUBCF(trainData,testData,num,support)
  %格式化dataFormat();%用户分组%%1.构建用户偏好矩阵%matrix=userPrefrence(data);
  %%2.粗糙聚类
  %用户相似矩阵 
  if(exist('UBCF_SIM.mat','file')>0)
      load('UBCF_SIM.mat');
  else
      SIM = SIMMatrix(trainData);
       save  UBCF_SIM.mat SIM;
  end
%   
%   if(exist('Granular_RoughData.mat','file')>0)
%       load('Granular_RoughData.mat');
%   else
      RoughData = RoughClusterWithScore( SIM,trainData,support );
      save  Granular_RoughData.mat RoughData;
%   end
  users=trainData(:,1);
  users(1)=[];
  Apha=support;
  numNeighor=30;
  result=zeros(length(users),6);
  for i=1:length(users)
      userid=users(i);
      itemsOrg=testData(testData(:,1)==userid,2:size(testData,2));
      userPreferenceItems=getPreferenceItems(userid,trainData(2:size(trainData,1),:));
      [itemsRec,mae,compare]=GranularUBCF(userid,userPreferenceItems,RoughData,SIM,num,Apha,numNeighor,itemsOrg);
      THRESHOLD=getTHRESHOLDFromPreference(userPreferenceItems);
      result(i,:)=[userid,mae,EvaluateParam(itemsRec,itemsOrg,THRESHOLD),compare.radio];
      statistic{i}=compare;
  end
end
