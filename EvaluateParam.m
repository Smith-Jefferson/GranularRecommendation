%1.matalab 推荐系统测试函数
%1.1 MAE
%1.2 查准�?%1.3 查全�?
%采用二位数组,[itemid,itemscore]
function Param=EvaluateParam(itemsRec,itemsOrg)
  MAR=EvaluateByMAE(itemsRec,itemsOrg);
  [P,R,F]=EvaluateByPRF(itemsRec,itemsOrg);
  Param=[MAR,P,R,F];
end

function mae=EvaluateByMAE(itemsRec,itemsOrg)
  mae=0;
  num=0;
  for i=1:size(itemsRec,1)
    idx=find(itemsOrg(:,1)==itemsRec(i,1));
    if(~isempty(idx))
      mae=mae+abs(itemsRec(i,2)-itemsOrg(idx,2));
      num=num+1;
    end
  end
  if num~=0
    mae=mae/num;
  end
end
%P: 准确率定义为系统的推荐列表中用户喜欢的产品和�?��被推荐产品的比率:，准确率表示用户对一个被推荐产品感兴趣的可能�?%R:召回率定义为推荐列表中用户喜欢的产品与系统中用户喜欢的所有产品的比率，召回率表示�?��用户喜欢的产品被推荐的概�?%F:为了同时考察准确率和召回�?, Pazzan iM 等把二�?综合考虑提出�?F指标 。F指标定义为F=(2PR)/(P+R)
function [P,R,F]=EvaluateByPRF(itemsRec,itemsOrg)
  num=0;
  F = 0; R = 0; P = 0;
  for i=1:size(itemsRec,1)
    idx=find(itemsOrg(:,1)==itemsRec(i,1));
    if(~ISEMPTY(idx))
      num=num+1;
    end
  end
  if num~=0
    P=num/size(itemsRec,1);
    R=num/size(itemsOrg,1);
    F=2*P*R/(P+R);
  end
end
