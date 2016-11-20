function [ Cluster ] = RoughCluster( SIM ,afa,beta)
    %SIM�û�֮��������Ծ���
    %�õ������û��ľ���
    support=afa;
    %��ʼ����
    neighborhoods=cell(size(SIM,1),1);
    for i=1:size(SIM,1)
        neighborhood=getUsersByUserSim(i,SIM,support,-1);
        neighborhoods{i}=[i,neighborhood(:,1)'];
    end
    %�����ϲ�
    Cluster=mergeCluster(neighborhoods,beta);%��ϲ����Լ���֮������ƶ�
    %result=adjustCluster(Cluster);%��ͬ����ϲ�
end
