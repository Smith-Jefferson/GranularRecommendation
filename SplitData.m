 %导入数据，格式化dataFormat();
function train = SplitData(num)
   if(exist('REC_DATA.mat','file')>0)
      load('REC_DATA.mat');
   else
      step=1/num;
      data=importdata('ml-100k\train.txt');
      test=importdata('ml-100k\test.txt');
      data=[data;test];
      data=sortrows(data,1);
      rand('seed',0);
      r=rand(size(data,1),1);
      begin=0;
      train=cell(1,num);
      for i=1:num
       after=begin+step;
       train{i}=data(r>=begin&r<after,:);
       begin=after;
      end
      save  REC_DATA.mat train;
  end
  
end