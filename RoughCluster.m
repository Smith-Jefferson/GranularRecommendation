function [ result ] = RoughCluster( SIM )
    %SIM�û�֮��������Ծ���
    %�õ������û��ľ���
    support=0.45;
    %��ʼ����
    neighborhoods=cell(size(SIM,1),1);
    for i=1:size(SIM,1)
        neighborhood=getUsersByUserSim(i,SIM,support,-1);
        neighborhoods{i}=[i,neighborhood(:,1)'];
    end
    %�����ϲ�
    
    Cluster=mergeCluster(neighborhoods,support);%��ϲ����Լ���֮������ƶ�
    result=adjustCluster(Cluster);%��ͬ����ϲ�
end
