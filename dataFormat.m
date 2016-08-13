function [ data ,test] = dataFormat()
  data=importdata('C:\Users\qiannw\Downloads\ml-100k\ml-100k\u1.base');
  data=sortrows(data,1);
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

  test=importdata('C:\Users\qiannw\Downloads\ml-100k\ml-100k\u1.test');
end
