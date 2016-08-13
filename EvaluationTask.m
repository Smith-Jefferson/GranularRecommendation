function EvaluationTask
  [data,test]=dataFormat();
  recommendations.trainData=userPrefrence(data);
  recommendations.testData=test;
  recommendations.func=[EvaluateIBCF,EvaluateUBCF,EvaluateGranular];
  result=EvaluateRecommendation(recommendations);
  plotEvaluation(result);
end
