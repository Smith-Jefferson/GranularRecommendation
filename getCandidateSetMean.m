function [candiset,statistic]=getCandidateSetMean(userid,userPreference,cluster,clusterGene)
  userGene=getPreference(userid,userPreference);

  candiset=clusterGene(userid,:);
  sim=personCorrelation(userGene,candiset);
  lx=userGene~=0;
  ldx=candiset~=0;
  candiset(ldx)=sim*mean(userGene(lx))-mean(candiset(lx))+candiset(ldx);
  candiset(isnan(candiset))=0;
  candiset(candiset<0)=0;
  candiset(candiset>5)=5;
  statistic=length(cluster{userid,1})/sum(candiset~=0);
  statistic=repmat(statistic,1,length(userGene));
 % radio=sum(sims(:,1)>0)/length(sims);
end
