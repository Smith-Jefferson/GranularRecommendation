 %导入数据，格式化dataFormat();
function [ train ,test] = dataFormat(split)
  split=1-split;
  data=importdata('ml-100k\train.txt');
  test=importdata('ml-100k\test.txt');
  data=[data;test];
  data=sortrows(data,1);
  rand('seed',0);
  r=rand(size(data,1),1);
  train=data(r>=split,:);
  test=data(r<split,:);
  %index = unique(data(:,3));
  %[I N]=hist(data(:,3),index);
  %I=I./max(I);
  %plot(index,I);
  % U=dataean(I);
  % D=var(I);
  % %D=sqrt(D);
  % x=0:0.01:max(index);
  % y=normpdf(x,U,D);
  % hold on;
  % plot(x,y)


%   for i=1:size(test,1)
%       data(data(:,1)==test(i,1) & data(:,2)==test(i,2),:)=[];
%   end
end
