function [ clusterSim,afterMergeCluster ] = mergeCluster2( cluster,support )
    %构建类的相似矩阵
    clusterSim=zeros(length(cluster),length(cluster));
    for i=1:length(cluster)
        current=cluster{i};
        for j=1:length(cluster)
            clusterSim(i,j)=length(intersect(current,cluster{j}))/max(length(current),length(cluster{j}));
        end
    end
    
    afterMergeCluster=cell(size(cluster));
    for i=1:size(clusterSim,1)
        vectorSim=clusterSim(i,:);
        vectorSim=sort(vectorSim,'descend'); 
        vector={};
        for j=1:length(vectorSim)
            if(~isnan(vectorSim(j)) && vectorSim(j)>1-support)
                 q=find(clusterSim(i,:) == vectorSim(j));
                 q=q(1);
                 clusterSim(i,q)=0;
                 temp=unique([cell2mat(vector),cell2mat(cluster(q))]);
                if length(cluster{i})/length(temp)>support
                    vector{1}=temp;
                end
            else
                break;
            end
        end
        afterMergeCluster(i)=vector;
    end
end

