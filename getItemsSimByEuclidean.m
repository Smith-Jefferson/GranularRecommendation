function itemSim=getItemsSimByEuclidean(itemMatrix)
  itemsNum=size(itemMatrix,1);
  itemSim=eye([itemsNum,itemsNum]);
  col=size(itemMatrix,2);
  for i=1:itemsNum
    for j=i+1:itemsNum
      sim=getItemSimilarity(itemMatrix(i,2:col),itemMatrix(j,2:col));
      itemSim(i,j)=sim;
      itemSim(j,i)=sim;
    end
  end
end

