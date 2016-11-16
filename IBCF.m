function [recItems,mae,compare]=IBCF(userid,itemMatrix,itemSim,num,testItems)
  userPreference=itemMatrix(:,userid+1);
  ldx=userPreference~=0;
  sims=itemSim(ldx,:);
  userPreference(~ldx,:)=[];
  recSet=sims.*repmat(userPreference,1,size(sims,2));
  recSet=sum(recSet)./sum(sims);
  %排除已经购买的
  recSet(ldx)=0;
  recSet(isnan(recSet))=0;

  %throw out the estimate if it was based on no data points,
  %of ocurse,but also if based on just one.this is a bit of a band-aid on the 'stock' item-based algorithm for the moment.
  %the reason is that in this case the estimate is,simply,
  %the user's rating for one item that happened to have a defined similarity.the similarity score doesn't matter,
  %and that seems like a bad situation
  recSet(sum(sims>0)==1)=0;
  mae=0;
  
  statistic=zeros(size(testItems,1),2);
  compare.radio=0;
  compare.detail=statistic;
  if size(testItems,1)>0
      for i=1:size(testItems,1)
          ind=find(itemMatrix(:,1)==testItems(i,1));
          if ind~=0
              diff=abs(testItems(i,2)-recSet(ind));
              mae=mae+diff;
              
              tmpidx=itemSim(:,ind)>0;
              statistic(i,1)=sum(sum(itemMatrix(tmpidx&ldx,2:size(itemMatrix,2))>0)>0)/sum(sum(itemMatrix(tmpidx,2:size(itemMatrix,2))>0,2)>2);%用户/items
              statistic(i,2)=diff;
          end
      end
      compare.radio=sum(statistic(:,1))/sum(statistic(:,1)>0);
      compare.detail=statistic;
      mae=mae/size(testItems,1);
  end
  
  if(num>length(recSet))
      num=length(recSet);
  end
  [recSet,index]=sort(recSet,'descend');
  recItems=[index(1:num)',recSet(1:num)'];
  recItems(recItems(:,2)<=0,:)=[];
  for i=1:size(recItems,1)
      recItems(i,1)=itemMatrix(recItems(i,1),1);
  end
  disp([num2str(userid),':recommendationItems : ', num2str(recItems(:,1)')]);
  disp([num2str(userid),':recommendationScore : ', num2str(recItems(:,2)')]);
  writeRecLog(userid,recItems);
end


