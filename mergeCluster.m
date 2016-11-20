function [afterMergeCluster]  = mergeCluster( cluster,beta )
    %构建类的相似矩阵
    clusterSim=zeros(length(cluster),length(cluster));
    afterMergeCluster=cell(size(cluster));
    for i=1:length(cluster)
        current=cluster{i};
        for j=1:length(cluster)
            if i==j
                continue;
            end
            clusterSim(i,j)=1-length(intersect(cluster{i},cluster{j}))/length(cluster{i});
            if(~isnan(clusterSim(i,j)) && clusterSim(i,j)<beta)
                current=unique([current,cell2mat(cluster(j))]);
            end
        end
        afterMergeCluster{i}=current;
    end
    
%     afterMergeCluster=cell(size(cluster));
%     for i=1:size(clusterSim,1)
%         vector={};
%         for j=i:size(clusterSim,2)
%             if(~isnan(clusterSim(i,j)) && clusterSim(i,j)>1-support)
%                 vector{1}=unique([cell2mat(vector),cell2mat(cluster(j))]);
%             end
%         end
%         afterMergeCluster(i)=vector;
%     end
end

