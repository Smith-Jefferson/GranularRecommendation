function [ train ,test] = dataSplit
  data=importdata('ml-100k\u.data');
  userids = unique(data(:,1));
  itemids=unique(data(:,2));
  umatrix=[];
  count=1;
  for i=1:length(userids)
    if count>500
        break;
    end
    uid=userids(i);
    lx=data(:,1)==uid;
    if sum(lx)>40
      umatrix=[umatrix;data(lx,:)];
      count=count+1;
    end
  end
  userids = unique(umatrix(:,1));
  itemids=unique(umatrix(:,2));
  %生成9份数据
  ML_100=umatrix(umatrix(:,1)<=userids(100),:);
  ML_200=umatrix(umatrix(:,1)<=userids(200),:);
  ML_300=umatrix(umatrix(:,1)<=userids(300),:);
  test=umatrix(umatrix(:,1)>userids(300),:);
  test5=[];
  test10=[];
  test20=[];
  left5=[];
  left10=[];
  left20=[];
  testusers=unique(test(:,1));
  for i=1:length(testusers)
    uid=testusers(i);
    utest=test(test(:,1)==uid,:);
    count=length(utest);
    test5=[test5;utest(end-5+1:1:end,:)];
    test10=[test10;utest(end-10+1:1:end,:)];
    test20=[test20;utest(end-20+1:1:end,:)];
    left5=[left5;utest(1:count-5,:)];
    left10=[left10;utest(1:count-10,:)];
    left20=[left20;utest(1:count-20,:)];
  end
  train.ML_100_5=[ML_100;test5];
  train.ML_100_10=[ML_100;test10];
  train.ML_100_20=[ML_100;test20];
  train.ML_200_5=[ML_200;test5];
  train.ML_200_10=[ML_200;test10];
  train.ML_200_20=[ML_200;test20];
  train.ML_300_5=[ML_300;test5];
  train.ML_300_10=[ML_300;test10];
  train.ML_300_20=[ML_300;test20];

  test.ML_100_5=left5;
  test.ML_100_10=left10;
  test.ML_100_20=left20;
  test.ML_200_5=left5;
  test.ML_200_10=left10;
  test.ML_200_20=left20;
  test.ML_300_5=left5;
  test.ML_300_10=left10;
  test.ML_300_20=left20;
end
