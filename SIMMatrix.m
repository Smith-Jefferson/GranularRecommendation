function [ SIM ] = SIMMatrix( matrix )
    %users ��������е��û�
    %����ģ�����ƾ���
    SIM=zeros(size(matrix,1),size(matrix,1));
    for i=1:size(matrix,1)
        for j=1:size(matrix,1)
            %���������ϵ��
            SIM(i,j)=personCorrelation(matrix(i,2:size(matrix,2)),matrix(j,2:size(matrix,2)));
        end
    end
end
