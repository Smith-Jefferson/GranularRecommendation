%1.matalab �Ƽ�ϵͳ���Ժ���
%1.1 MAE
%1.2 ��׼%1.3 ��ȫ
%���ö�λ����,[itemid,itemscore]
function Param=EvaluateParam(itemsRec,itemsOrg,THRESHOLD)
  [P,R,F]=EvaluateByPRF(itemsRec,itemsOrg,THRESHOLD);
  Param=[P,R,F];
end

%P: ׼ȷ�ʶ���Ϊϵͳ���Ƽ��б����û�ϲ���Ĳ�Ʒ�ͱ��Ƽ���Ʒ�ı���:��׼ȷ�ʱ�ʾ�û���һ�����Ƽ���Ʒ����Ȥ�Ŀ���
%R:�ٻ��ʶ���Ϊ�Ƽ��б����û�ϲ���Ĳ�Ʒ��ϵͳ���û�ϲ�������в�Ʒ�ı��ʣ��ٻ��ʱ�ʾ�û�ϲ���Ĳ�Ʒ���Ƽ��ĸ�
%F:Ϊ��ͬʱ����׼ȷ�ʺ��ٻ�, Pazzan iM �ȰѶ��ۺϿ������Fָ�� ��Fָ�궨��ΪF=(2PR)/(P+R)
function [P,R,F]=EvaluateByPRF(itemsRec,itemsOrg,THRESHOLD)
  num=0;
  F = 0; R = 0; P = 0;
  %������ֵˢѡ��С����ֵ�Ĳ������ݣ���Ϊ���������ֵ�Ĳ������ݲ��ᱻ�Ƽ�
  itemsOrg(itemsOrg(:,2)<THRESHOLD,:)=[];
  %���㽻��
  for i=1:size(itemsRec,1)
    idx=itemsOrg(:,1)==itemsRec(i,1);
    if(sum(idx))
      num=num+1;
    end
  end
  if num~=0
    P=num/size(itemsRec,1);
    R=num/size(itemsOrg,1);
    F=2*P*R/(P+R);
  end
end
