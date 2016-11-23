function crossUserLevelGranularMerge
    data=importdata('ml-100k\train.txt');
    test=importdata('ml-100k\test.txt');
    data=[data;test];
    data=sortrows(data,1);
    crossNum=3;
    if(exist('REC_indices.mat','file')>0)
        load('REC_indices.mat');
    else
        indices = crossvalind('Kfold', size(data,1), crossNum);%将数据样本随机分割为3部分
    end
    maes=cell(1,crossNum);
    decides=cell(1,crossNum);
    for i = 1:crossNum %循环3次，分别取出第i部分作为测试样本，其余两部分作为训练样本
        test = (indices == i);
        train = ~test;
        trainData = data(train, :);
        testData = data(test, :);
        trainData=userPrefrence(trainData);
        [mae,decide]=UserLevelGranularMerge(trainData,testData);
        maes{i}=mae;
        decides{i}=decide;
    end
    save crossUserLevelGranularMerge_mae.mat maes;
    save crossUserLevelGranularMerge_decide.mat decides;
end



