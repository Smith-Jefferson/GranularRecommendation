function plotEvaluation(result)
  load('result.mat');
  for i=1:length(result)
      figure(i);
      set=[];
      set=result{1,i};
        ldx=find(set(:,2)~=0);
        maeSet=set(ldx,2);
        mae=sum(maeSet)/length(maeSet);
        plot(ldx,maeSet,'g');
        hold on;
        ymae=[];
        ymae(1:length(ldx))=mae;
        plot(ldx,ymae,'r','Linewidth',1.5);
        xlabel('�û�'); 
        ylabel('MAE');
        s1=sprintf('(%f)',mae);
        text(0,mae,s1);
%       if i==1
%            title('ʹ��MAE����ָ������IBCF�㷨');
%            %subplot(2,2,1);
%       else
          if i==1
           %subplot(2,2,2); 
           title('ʹ��MAE����ָ������UBCF�㷨');
%       elseif i==3
%           %subplot('position',[0.2,0.02,0.6,0.45]); 
%           %subplot(2,2,3);
%           title('ʹ��MAE����ָ������Granular�㷨');
      else
          %subplot(2,2,4);
          title('ʹ��MAE����ָ������GranularUBCF�㷨');
      end
  end
  
  
end