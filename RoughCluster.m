function [ result ] = RoughCluster( SIM )
    %SIM用户之间的相似性矩阵
    %得到的是用户的聚类
    support=0.45;
    %初始聚类
    for i=1:size(SIM,1)
        vector=[];
        for j=1:size(SIM,2)
            if(~isnan(SIM(i,j)) && SIM(i,j)>=support)
                vector=[vector,j];
            end
        end
        cluster{i}=vector;
    end

    %调整合并
    afterMergeCluster=mergeCluster(cluster,0.5);%类合并，以及类之间的相似度
    result=adjustCluster(afterMergeCluster);%相同的类合并
end
