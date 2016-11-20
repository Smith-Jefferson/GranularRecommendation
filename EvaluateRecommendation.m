%recommendations.trainData=matrix;
%recommendations.testData=testData;
%recommendations.func=[EvaluateIBCF,EvaluateUBCF,EvaluateGranular];

function EvaluateRecommendation(recommendations)
  Log('���ɲ��Կ�ʼ');
  result=cell(1,length(recommendations.func));
  compare=result;
  for i=1:length(recommendations.func)
    func=cell2mat(recommendations.func(i));
    Log([func,'���Կ�ʼ']);
    switch func
        case 'EvaluateIBCF'
            [r,c]=EvaluateIBCF(recommendations.trainData,recommendations.testData,recommendations.num);
            result{i}=r;
            compare{i}=c;
            continue;
        case 'EvaluateUBCF'
            [r,c]=EvaluateUBCF(recommendations.trainData,recommendations.testData,recommendations.num);
            result{i}=r;
            compare{i}=c;
            continue;
        case 'EvaluateGranular'
            [r,c]=EvaluateGranular(recommendations.trainData,recommendations.testData,recommendations.num);
            result{i}=r;
            compare{i}=c;
            continue;
        case 'EvaluateGranularUBCF'
            [r,c]=EvaluateGranularUBCF(recommendations.trainData,recommendations.testData,recommendations.num,0.5);
            result{i}=r;
            compare{i}=c;
            continue;
    end
    %Log(result{i});
  end
  save result.mat result;
  save compare.mat compare;
  Log('���ɲ��Խ���');
  plotEvaluation(result);
  %ResultCompare
end


