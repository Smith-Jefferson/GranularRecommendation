function EvaluationTask
  Log('׼������');
  [data,test]=dataFormat(0.9);
  recommendations.trainData=userPrefrence(data);
  recommendations.testData=test;
%  recommendations.func={'EvaluateIBCF','EvaluateUBCF','EvaluateGranular','EvaluateGranularUBCF'};
  recommendations.func={'EvaluateUBCF'};
  recommendations.num=10;
  EvaluateRecommendation(recommendations);
end
