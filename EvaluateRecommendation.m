recommendations.trainData=matrix;
recommendations.testData=testData;
recommendations.func=[IBCFRecommendation,UBCFRecommendation,GranularRecommendation];

function result=EvaluateRecommendation(recommendations)
  for i=1:length(recommendations.func)
    result(i)=recommendations.func(i)[recommendations.trainData,recommendations.testData];
  end
end

function plotEvaluation(result)
  
end
