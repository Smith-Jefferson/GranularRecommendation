function coeff=personCorrelation(X,Y)
%本函数实现了皮尔逊相关系数的计算操作
%
%输入：
%X：输入的数值序列
%Y：输入的数值序列
%
%输出：
%coeff：两个输入数值序列X，Y的相关系数
%
    if length(X) ~= length(Y)
        error('两个数值数列的维数不相等');
        return;
    end
    %忽略向量X,Y中项为0的列
    tempX=[];
    tempY=[];
    for i=1:length(X)
        temp=X(i)*Y(i);
        if(~isnan(temp) && temp~=0)
            tempX=[tempX,X(i)];
            tempY=[tempY,Y(i)];
        end
    end
    X=tempX;
    Y=tempY;
    fenzi=sum(X.*Y)-(sum(X)*sum(Y))/length(X);
    fenmu=sqrt((sum(X.^2)-sum(X)^2/length(X)) * (sum(Y.^2)-sum(Y)^2/length(X)));
    coeff=fenzi/fenmu;
end
