function [ NewData ] = RoughClusterWithScore( SIM,trainData,support )
    %SIM�û�֮��������Ծ���
    %�õ������û��ľ���
    %��ʼ����
    SIM(isnan(SIM))=0;
    NewData=zeros(size(trainData));NewData(:,1)=trainData(:,1);NewData(1,:)=trainData(1,:);
    trainData(1,:)=[];
    user=trainData(:,1);
    for i=1:size(SIM,1)
        neighborhood=getUsersByUserSim(i,SIM,support,-1);
        %neighborhood(:,1)=user(neighborhood(:,1));
        neighborItems=trainData(neighborhood(:,1),2:size(trainData,2));
        userid=find(trainData(:,1)==i);
        if isempty(userid)
            continue;
        end
        neighborItems(:,trainData(userid,2:size(trainData,2))>0)=0;
        neighbormatrix=repmat(neighborhood(:,2),1,size(neighborItems,2));
        Items=neighborItems.*neighbormatrix;
        neighbormatrix(Items==0)=0;
        Items=sum(Items);
        Items=Items./sum(neighbormatrix);
        %���ֻ��һ���ھ��Ƽ�����Ʒ����ȡ�Ĳ����Ƿ���
        for j=1:size(neighborItems,2)
            if sum(neighbormatrix(:,j)>0)<=1
                Items(j)=0;
            end
        end
       %ȥ��NAN
       Items(isnan(Items))=0;
       NewData(userid+1,2:size(trainData,2))=trainData(userid,2:size(trainData,2))+Items;
    end
end



