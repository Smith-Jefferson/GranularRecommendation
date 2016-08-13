function [ result ] = RoughCluster( SIM )
    %SIM�û�֮��������Ծ���
    %�õ������û��ľ���
    support=0.45;
    %��ʼ����
    for i=1:size(SIM,1)
        vector=[];
        for j=1:size(SIM,2)
            if(~isnan(SIM(i,j)) && SIM(i,j)>=support)
                vector=[vector,j];
            end
        end
        cluster{i}=vector;
    end

    %�����ϲ�
    afterMergeCluster=mergeCluster(cluster,0.5);%��ϲ����Լ���֮������ƶ�
    result=adjustCluster(afterMergeCluster);%��ͬ����ϲ�
end
