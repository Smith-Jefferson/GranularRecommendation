%1.matalab 推荐系统测试函数
%1.1 MAE
%1.2 查准率
%1.3 查全率

%采用二位数组,[itemid,itemscore]
function mae=EvaluateByMAE(itemsRec,itemsOrg)
  mae=0;
  num=0;
  for i=1:size(itemsRec,1)
    idx=find(itemsOrg(:,1)==itemsRec(i,1));
    if(length(idx))
      mae=mae+abs(itemsRec[i][2]-itemsOrg[idx][2]);
      num=num+1;
    end
  end
  if num~=0
    mae=mae/num;
  end
end
%P: 准确率定义为系统的推荐列表中用户喜欢的产品和所有被推荐产品的比率:，准确率表示用户对一个被推荐产品感兴趣的可能性
%R:召回率定义为推荐列表中用户喜欢的产品与系统中用户喜欢的所有产品的比率，召回率表示一个用户喜欢的产品被推荐的概率
%F:为了同时考察准确率和召回率 , Pazzan iM 等把二者综合考虑提出了 F指标 。F指标定义为F=(2PR)/(P+R)
function [P,R,F]=EvaluateByPRF(itemsRec,itemsOrg)
  num=0;
  F = 0; R = 0; P = 0;
  for i=1:size(itemsRec,1)
    idx=find(itemsOrg(:,1)==itemsRec(i,1));
    if(length(idx))
      num=num+1;
    end
  end
  if num~=0
    P=num/size(itemsRec,1);
    R=num/size(itemsOrg,1);
    F=2*P*R/(P+R);
end
