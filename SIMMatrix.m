function [ SIM ] = SIMMatrix( matrix )
    %users 存放了所有的用户
    %构建模糊相似矩阵
    SIM=zeros(size(matrix,1),size(matrix,1));
    for i=1:size(matrix,1)
        for j=1:size(matrix,1)
            %向量的相关系数
            SIM(i,j)=personCorrelation(matrix(i,2:size(matrix,2)),matrix(j,2:size(matrix,2)));
        end
    end
end
