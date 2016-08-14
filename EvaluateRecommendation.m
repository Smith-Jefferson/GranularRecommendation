%recommendations.trainData=matrix;
%recommendations.testData=testData;
%recommendations.func=[EvaluateIBCF,EvaluateUBCF,EvaluateGranular];

function EvaluateRecommendation(recommendations)
  Log('���ɲ��Կ�ʼ');
  for i=1:length(recommendations.func)
    func=cell2mat(recommendations.func(i));
    Log([func,'���Կ�ʼ']);
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
  Log('���ɲ��Խ���');
  plotEvaluation(result);
end

function plotEvaluation(result)

end
