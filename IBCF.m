function recItems=IBCF(userid,itemMatrix,itemSim,num)
  userPreference=itemMatrix(:,userid);
  ldx=userPreference~=0;
  sims=itemSim(ldx,:);
  userPreference(~ldx,:)=[];
  recSet=sims.*repmat(userPreference,1,size(sims,2));
  recSet=sum(recSet)./sum(sims);
  recSet(ldx)=0;
  [recSet,index]=sort(recSet,'descend');
  recItems=recSet(1:num);
  disp(['recommendationItems : ', num2str(index(1:num))]);
  disp(['recommendationScore : ', num2str(recItems)]);
end






