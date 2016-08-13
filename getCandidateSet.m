function candidateSet=getCandidateSet(userid,userPreference,cluster,clusterGene)
  userGene=getPreference(userid,userPreference);
  num=length(cluster);
  countN=0;
  sims=zeros(num,2);
  for i=1:num
    if any(userid==cluster{i})
        sim=personCorrelation(userGene,clusterGene(i,:));
    end
    if ~isnan(sim) && sim~=0
        sims(i,1)=sim;
        sims(i,2)=i;
        countN=countN+1;
    end
  end
  %πÈ“ªªØ 
  sims(:,1)=sims(:,1).*(1/sum(sims(:,1)));
  set=zeros(countN,length(clusterGene));
  for i=1:countN
    set(i,:)=sims(i,1).*clusterGene(sims(i,2),:);
  end
  ldx=find(isnan(set));
  set(ldx)=0;
  candidateSet=sum(set);
end