function EvaluationTask
  Log('准备数据');
  [data,test]=dataFormat();
  recommendations.trainData=userPrefrence(data);
  recommendations.testData=test;
  recommendations.func={'EvaluateIBCF','EvaluateUBCF','EvaluateGranular'};
  recommendations.num=10;
  EvaluateRecommendation(recommendations);
end
