function [recommendItems,mae,compare]=recommendation(userid,userPreference,candidateSet,num,isRemove,itemsTest,itemsIndex,statistic)
  userGene=getPreference(userid,userPreference);
  %取出已经购买的  
  if isRemove==true
      candidateSet(userGene~=0)=0;
  end
  [items,index]=sort(candidateSet,'descend');
  statistic=statistic(index);
  recItems=[index',items'];

  %根据序号找到对应的itemID
  for i=1:length(recItems)
      recItems(i,1)=itemsIndex(recItems(i,1));  
  end
  %求MAE
  mae=0;
  count=0;
  detail=zeros(size(itemsTest,1),2);
  for i=1:size(itemsTest,1)
      ind=find(recItems(:,1)==itemsTest(i,1));
      if (ind~=0 & recItems(ind,2)>0)
          diff=abs(itemsTest(i,2)-recItems(ind,2));
         mae=mae+diff;
         count=count+1;
         detail(i,:)=[statistic(ind),diff];
      else
         detail(i,:)=[0,NaN];
      end
  end
  if count<=0
      mae=0;
  else
      mae=mae/count;
  end
  compare.radio=sum(detail(:,1))/count;
  compare.detail=detail;
  recommendItems=recItems(1:num,:);
  disp([num2str(userid),':recommendationItems : ', num2str(recommendItems(:,1)')]);
  disp([num2str(userid),':recommendationScore : ', num2str(recommendItems(:,2)')]);
end