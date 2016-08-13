function clusterGene=produceClusterGene(cluster,matrix)
  matrix(:,1)=[];
  clusterGene=zeros(length(cluster),size(matrix,2));
  for i=1:length(cluster)
    items=matrix(cluster{i},:);
    clusterGene(i,:)=sum(items)./sum(items~=0,1);
  end
end