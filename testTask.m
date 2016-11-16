function testTask
    data=SplitData(6);
    train=data{1,1};
    for i=2:length(train)
        trainData=userPrefrence(train);
        test=data{1,i};
        [result]=LevelGranularRec(trainData,test,10,0.5);
        train=[train;test];
    end
end

