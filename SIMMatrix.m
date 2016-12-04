function [ SIM ] = SIMMatrix( matrix )
    %users 存放了所有的用户
    %构建模糊相似矩阵
    matrix(1,:)=[];
    SIM=zeros(size(matrix,1),size(matrix,1));
    for i=1:size(matrix,1)
        for j=i+1:size(matrix,1)
            %向量的相关系数
            sim=0.5*personCorrelation(matrix(i,2:size(matrix,2)),matrix(j,2:size(matrix,2)))+0.5*logLikelihoodSimilarity(matrix(i,2:size(matrix,2)),matrix(j,2:size(matrix,2)));
            SIM(i,j)=sim;
            SIM(j,i)=sim;
        end
    end
end
