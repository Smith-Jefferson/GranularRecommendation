function [recommendItems,mae,compare]=GranularUBCF(userid,userPreferenceItems,matrix,SIM,num,Apha,numNeighor,testItems)
  itemIndex=matrix(1,:);
  itemIndex(1)=[];
  matrix(1,:)=[];
  %根据items获取用户组
  userIndex=find(matrix(:,1)==userid);
  neighbor=getUsersByUserSim(userIndex,SIM,Apha,numNeighor);
  candidateSet=getCandidateSet(neighbor(:,1),matrix);
  [recItems,statistic]=calculateScoreByUserSim(candidateSet,neighbor);
  recItems=removeBuyed(userPreferenceItems,recItems);
  
  detail=zeros(size(testItems,1),2);
  %计算MAE
  mae=0;
  if size(testItems,1)>0
      count=0;
      for i=1:size(testItems,1)
          ind=find(itemIndex==testItems(i,1));
          if ind~=0  
             ind=find(recItems(:,1)==ind);
          end
          if (ind~=0 & recItems(ind,2)~=0)
              diff=abs(testItems(i,2)-recItems(ind,2));
              mae=mae+diff;
              count=count+1;
              detail(i,:)=[statistic(ind),diff];
          end
      end
      if count<=0
          mae=0;
      else
          mae=mae/count;
      end
  end
  compare.detail=detail;
  compare.radio=sum(detail(:,1))/size(detail,1);
  
  if(num==-1)
      num=length(recItems);
  end
  recommendItems=recItems(1:num,:);
  for i=1:num
      recommendItems(i,1)=itemIndex(recommendItems(i,1));
  end
  %disp(['recommendationItems : ', num2str(recommendItems(:,1)')]);
  %disp(['recommendationScore : ', num2str(recommendItems(:,2)')]);
  %writeRecLog(userid,recommendItems);
end

function recItems=removeBuyed(buyed,recItems)
    for i=1:length(buyed)
        recItems(recItems(:,1)==buyed(i),:)=[];
    end
end

function neighbor=getUsersByItems(items,matrix)
  for i=1:length(items)
    [indX,~]=find(matrix==items(i));
    neighbor=union(neighbor,indX);
    neighbor=setdiff(neighbor,userid);
  end
end

function candidateSet=getCandidateSet(neighbor,matrix)
  matrix(:,1)=[];
  candidateSet=matrix(neighbor,:);
end

function [recItems,statistic]=calculateScoreByUserSim(candidateSet,neighbor)
  neighbormatrix=repmat(neighbor(:,2),1,size(candidateSet,2));
  Items=candidateSet.*neighbormatrix;
  neighbormatrix(Items==0)=0;
  Items=sum(Items);
  Items=Items./sum(neighbormatrix);
  %如果只有一个邻居推荐该商品，采取的策略是放弃
  for i=1:size(candidateSet,2)
      if sum(neighbormatrix(:,i)>0)<=1
          Items(i)=0;
      end
  end
  %去除NAN
  Items(isnan(Items))=0;
  [itm,index]=sort(Items,'descend');
  recItems=[index',itm'];
  %recItems(recItems(:,2)==0,:)=[];
  
  statistic=sum(neighbormatrix>0)/size(neighbormatrix,1);
  statistic=statistic(index);
end

