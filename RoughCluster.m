function [ Cluster ] = RoughCluster( SIM ,afa,beta)
    %SIM用户之间的相似性矩阵
    %得到的是用户的聚类
    support=afa;
    %初始聚类
    neighborhoods=cell(size(SIM,1),1);
    for i=1:size(SIM,1)
        neighborhood=getUsersByUserSim(i,SIM,support,-1);
        neighborhoods{i}=[i,neighborhood(:,1)'];
    end
    %调整合并
    Cluster=mergeCluster(neighborhoods,beta);%类合并，以及类之间的相似度
    %result=adjustCluster(Cluster);%相同的类合并
end
