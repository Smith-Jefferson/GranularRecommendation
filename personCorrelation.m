function coeff=personCorrelation(X,Y)
%������ʵ����Ƥ��ѷ���ϵ���ļ������
%
%���룺
%X���������ֵ����
%Y���������ֵ����
%
%�����
%coeff������������ֵ����X��Y�����ϵ��
%
    if length(X) ~= length(Y)
        error('������ֵ���е�ά�������');
        return;
    end
    %��������X,Y����Ϊ0����
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
