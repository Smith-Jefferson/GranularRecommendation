
load('smalldesision.mat');
smalldesisionA=zeros(1,size(smalldesision,2));
for i=1:size(samlldesision,2)
    ones=sum(samlldesision(:,i)==1);
    twos=sum(samlldesision(:,i)==2);
    if twos>ones
        smalldesisionA(i)=2;
    else
        smalldesisionA(i)=1;
    end
end


data=importdata('ml-100k\train.txt');
rand('seed',0);
r=rand(size(data,1),1);
index=r>0.2;
train=data(index,:);
test=data(~index,:);
trainData=userPrefrence(train);
[mae,decide]=UserLevelGranularMerge(trainData,test);
users=trainData(:,1);
users(1)=[];

load('smallmerge.mat');

plot(users,mae(2,:),'.b');
hold on;
mmae=mean(mae(2,:));
ymae(1:length(users))=mmae;
plot(users,ymae,'r','Linewidth',1.5);
xlabel('用户'); 
ylabel('MAE');
title('使用MAE评价指标评价UBCF算法');
s1=sprintf('(%f)',mmae);
text(0,mmae,s1);

plot(users,mae(3,:),'.g');
hold on;
mmae=mean(mae(3,:));
ymae(1:length(users))=mmae;
plot(users,ymae,'r','Linewidth',1.5);
xlabel('用户'); 
ylabel('MAE');
title('使用MAE评价指标评价GranularUBCF算法');
s1=sprintf('(%f)',mmae);
text(0,mmae,s1);

plot(users,mae(1,:),'.b');
hold on;
mmae=mean(mae(1,:));
ymae(1:length(users))=mmae;
plot(users,ymae,'r','Linewidth',1.5);
xlabel('用户'); 
ylabel('MAE');
s1=sprintf('(%f)',mmae);
text(0,mmae,s1);

%smalldesisionA=smalldesisionA+1;
newMae=zeros(1,size(smalldesisionA,2));
for i=1:size(smalldesisionA,2)
    newMae(i)=mae(smalldesisionA(i),i);
end
hold on;
plot(users,newMae(1,:),'.g');
hold on;
mmae=mean(newMae);
ymae(1:length(users))=mmae;
plot(users,ymae,'r','Linewidth',1.5);
s1=sprintf('(%f)',mmae);
text(0,mmae,s1);
xlabel('用户'); 
ylabel('MAE');


