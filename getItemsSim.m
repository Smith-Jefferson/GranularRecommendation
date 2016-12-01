function itemSim=getItemsSim(itemMatrix)
  itemsNum=size(itemMatrix,1);
  itemSim=zeros([itemsNum,itemsNum]);
  col=size(itemMatrix,2);
  for i=1:itemsNum
    for j=i+1:itemsNum
      sim=logLikelihoodSimilarity(itemMatrix(i,2:col),itemMatrix(j,2:col));
      itemSim(i,j)=sim;
      itemSim(j,i)=sim;
    end
  end
end