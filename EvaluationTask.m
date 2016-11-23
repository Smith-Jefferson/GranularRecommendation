function EvaluationTask
  Log('准备数据');
  [data,test]=dataFormat(0.9);
  recommendations.trainData=userPrefrence(data);
  recommendations.testData=test;
%  recommendations.func={'EvaluateIBCF','EvaluateUBCF','EvaluateGranular','EvaluateGranularUBCF'};
  recommendations.func={'EvaluateGranular'};
  recommendations.num=10;
  recommendations.afa=0.7;
  recommendations.beta=0.1;
  EvaluateRecommendation(recommendations);
end
