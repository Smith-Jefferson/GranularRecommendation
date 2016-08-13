function recommendItems=recommendation(userid,userPreference,candidateSet,num,isRemove)
  [items,index]=sort(candidateSet,'descend');
  userGene=getPreference(userid,userPreference);
  %取出已经购买的  
  if isRemove==true
    index=setdiff(index,find(userGene~=0));
  end
  disp(['recommendationItems : ', num2str(index(1:num))]);
  disp(['recommendationScore : ', num2str(items(1:num))]);
  recommendItems=[index(1:num)',items(1:num)'];
end