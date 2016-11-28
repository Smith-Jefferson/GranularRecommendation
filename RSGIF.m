function result=RSGIF(trainData,testData,afa,beta)
  if(exist('IBCF_itemSim.mat','file')>0)
      load('IBCF_itemMatrix.mat');
      load('IBCF_itemSim.mat');
  else
      itemMatrix=getItemMatrix(trainData);
      itemSim=getItemsSimByEuclidean(itemMatrix);
      save  IBCF_itemMatrix.mat itemMatrix;
      save  IBCF_itemSim.mat itemSim;
  end
  itemSim(itemSim<afa)=0;
  users=trainData(2:size(trainData,1),1)';
  result=[];
  for i=1:length(users)
      userid=users(i);
      itemsOrg=testData(testData(:,1)==userid,2:size(testData,2));
      mae=IBCF(i,itemMatrix,itemSim,itemsOrg);
      %THRESHOLD=getTHRESHOLDFromMatrix(i,itemMatrix);
      %result(i,:)=[userid,mae,EvaluateParam(itemsRec,itemsOrg,THRESHOLD)];
      result=[result;mae];
  end
end

function mae=IBCF(userid,itemMatrix,itemSim,testItems)
  userPreference=itemMatrix(:,userid+1);
  ldx=userPreference~=0;
  sims=itemSim(ldx,:);
  userPreference(~ldx,:)=[];
  recSet=sims.*repmat(userPreference,1,size(sims,2));
  recSet=sum(recSet)./sum(sims);
  %ÅÅ³ýÒÑ¾­¹ºÂòµÄ
  recSet(ldx)=0;
  recSet(isnan(recSet))=0;

  %throw out the estimate if it was based on no data points,
  %of ocurse,but also if based on just one.this is a bit of a band-aid on the 'stock' item-based algorithm for the moment.
  %the reason is that in this case the estimate is,simply,
  %the user's rating for one item that happened to have a defined similarity.the similarity score doesn't matter,
  %and that seems like a bad situation
  recSet(sum(sims>0)==1)=0;
  mae=[];
  if size(testItems,1)>0
      for i=1:size(testItems,1)
          ind=find(itemMatrix(:,1)==testItems(i,1));
          if ind~=0 & recSet(ind)>0
              diff=abs(testItems(i,2)-recSet(ind));
              mae=[mae;[userid,testItems(i,1),diff]];
          else
              mae=[mae;[userid,testItems(i,1),NaN]];
          end
      end
  end
end
