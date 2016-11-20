function crossUserLevelGranularMerge
    data=importdata('ml-100k\train.txt');
    test=importdata('ml-100k\test.txt');
    data=[data;test];
    data=sortrows(data,1);
    crossNum=3;
    if(exist('REC_indices.mat','file')>0)
        load('REC_indices.mat');
    else
        indices = crossvalind('Kfold', size(data,1), crossNum);%��������������ָ�Ϊ3����
    end
    maes=cell(1,crossNum);
    decides=cell(1,crossNum);
    for i = 1:crossNum %ѭ��3�Σ��ֱ�ȡ����i������Ϊ����������������������Ϊѵ������
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



