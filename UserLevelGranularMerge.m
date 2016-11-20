function [mae,decide]=UserLevelGranularMerge(trainData,testData)
%       if(exist('UBCF_SIM1.mat','file')>0)
%           load('UBCF_SIM1.mat');
%       else
%           SIM = SIMMatrix(trainData);
%           save  UBCF_SIM1.mat SIM;
%       end
    SIM = SIMMatrix(trainData);
    support=0.1;
    RoughData = RoughClusterWithScore( SIM,trainData,support );
    users=trainData(:,1);
    users(1)=[];
    Apha=support;
    mae=zeros(3,length(users));
    decide=zeros(1,length(users));
    numNeighor=30;
    for i=1:length(users)
      userid=users(i);
      itemsOrg=testData(testData(:,1)==userid,2:size(testData,2));
      userPreferenceItems=getPreferenceItems(userid,trainData(2:size(trainData,1),:));
      [~,mae1,~]=UBCF(userid,trainData,SIM,-1,Apha,numNeighor,itemsOrg);
      [~,mae2,~]=GranularUBCF(userid,userPreferenceItems,RoughData,SIM,-1,Apha,numNeighor,itemsOrg);
      mae(:,i)=[min(mae1,mae2),mae1,mae2];
      if(mae1<=mae2)
          decide(i)=1;
      else
          decide(i)=2;
      end
  end
end