function result=adjustCluster(cluster)
    result={};
    result(1)=cluster(1);
    for i=2:length(cluster)
      flag=true;
      for j=1:length(result)
          sim=length(intersect(cluster{i},result{j}))/min(length(cluster{i}),length(result{j}));
          if(sim==1)
            cluster(j)={unique(union(cluster{i},result{j}))};
            flag=false;
            break;
          end
      end
      if flag == true
        result(length(result)+1)=cluster(i);
      end
    end
end

