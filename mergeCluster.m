function [afterMergeCluster]  = mergeCluster( cluster,support )
    %����������ƾ���
    clusterSim=zeros(length(cluster),length(cluster));
    afterMergeCluster=cell(size(cluster));
    for i=1:length(cluster)
        current=cluster{i};
        for j=1:length(cluster)
            clusterSim(i,j)=length(intersect(current,cluster{j}))/max(length(current),length(cluster{j}));
            if(~isnan(clusterSim(i,j)) && clusterSim(i,j)>=1-support)
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

