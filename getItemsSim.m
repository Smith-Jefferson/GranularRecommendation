function itemSim=getItemsSim(itemMatrix)
  itemScore=sum(itemMatrix.*itemMatrix,2);%”–Œ Ã‚
  itemsNum=size(itemMatrix,1);
  itemSim=eye([itemsNum,itemsNum]);
  for i=2:itemsNum
    for j=i+1:itemsNum
      sim=getItemSimilarity(itemMatrix(i,:),itemMatrix(j,:),itemScore,i,j);
      itemSim(i,j)=sim;
      itemSim(j,i)=sim;
    end
  end
end

function sim=getItemSimilarity(X,Y,itemScore,i,j)
  dot=sum(X.*Y);
  if dot~=0
    sim=1/(1+sqrt(itemScore(i)-2*dot+itemScore(j)));
  else 
    sim=0;
  end
end