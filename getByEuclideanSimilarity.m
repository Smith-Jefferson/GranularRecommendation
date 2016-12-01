function sim=getByEuclideanSimilarity(X,Y)
  sumdiff=0;
  count=0;
  for i=1:length(X)
      dot=X(i)*Y(i);
      if(~isnan(dot) && dot~=0)
          diff=X(i)-Y(i);
          sumdiff=sumdiff+diff*diff;
          count=count+1;
      end
  end
  if count>0
    sim=1/(1+sqrt(sumdiff)/sqrt(count));
  else 
    sim=0;
  end
end