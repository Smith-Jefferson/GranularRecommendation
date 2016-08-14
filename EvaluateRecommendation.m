%recommendations.trainData=matrix;
%recommendations.testData=testData;
%recommendations.func=[EvaluateIBCF,EvaluateUBCF,EvaluateGranular];

function EvaluateRecommendation(recommendations)
  Log('集成测试开始');
  for i=1:length(recommendations.func)
    func=cell2mat(recommendations.func(i));
    Log([func,'测试开始']);
    switch func
        case 'EvaluateIBCF'
            result(i)=EvaluateIBCF(recommendations.trainData,recommendations.testData,recommendations.num);
            break;
        case 'EvaluateUBCF'
            result(i)=EvaluateUBCF(recommendations.trainData,recommendations.testData,recommendations.num);
            break;
        case 'EvaluateGranular'
            result(i)=EvaluateGranular(recommendations.trainData,recommendations.testData,recommendations.num);
            break;
    end
    Log(result(i));
  end
  save result.mat result;
  Log('集成测试结束');
  plotEvaluation(result);
end

function plotEvaluation(result)

end
