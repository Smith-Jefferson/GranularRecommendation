function [ SIM ] = SIMMatrix( matrix )
    %users ��������е��û�
    %����ģ�����ƾ���
    matrix(1,:)=[];
    SIM=zeros(size(matrix,1),size(matrix,1));
    for i=1:size(matrix,1)
        for j=i+1:size(matrix,1)
            %���������ϵ��
            sim=0.5*personCorrelation(matrix(i,2:size(matrix,2)),matrix(j,2:size(matrix,2)))+0.5*logLikelihoodSimilarity(matrix(i,2:size(matrix,2)),matrix(j,2:size(matrix,2)));
            SIM(i,j)=sim;
            SIM(j,i)=sim;
        end
    end
end
