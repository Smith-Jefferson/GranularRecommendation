function recommendItems=UBCF(userid,matrix,SIM,num,Apha)
  items=getPreferenceItems(userid,matrix);
  %根据items获取用户组
  neighbor=getUsersByUserSim(userid,SIM,Apha);
  candidateSet=getCandidateSet(neighbor(:,1),matrix);
  recItems=calculateScoreByUserSim(candidateSet,neighbor);
  items=intersect(items,recItems(:,1)');
  recItems(items',:)=[];
  recommendItems=recItems(1:num,:);
  disp(['recommendationItems : ', num2str(recommendItems(:,1)')]);
  disp(['recommendationScore : ', num2str(recommendItems(:,2)')]);
end

function items=getPreferenceItems(userid,matrix)
    items=getPreference(userid,matrix);
    items=find(items~=0);
end

function neighbor=getUsersByUserSim(userid,SIM,Apha)
  neighbor=SIM(userid,:)>Apha;
  similarty=SIM(userid,SIM(userid,:)>Apha);
  neighbor=[find(neighbor==true)',similarty'];
  neighbor(userid,:)=[];
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

function recItems=calculateScoreByUserSim(candidateSet,neighbor)
  Items=candidateSet.*repmat(neighbor(:,2),1,size(candidateSet,2));
  Items=sum(Items);
  Items=Items/sum(neighbor(:,2));
  [itm,index]=sort(Items,'descend');
  recItems=[index',itm'];
  recItems(recItems(:,2)==0,:)=[];
end