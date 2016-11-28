function [ mae,rmse ] = GlobalMAE(data)
%   load('compare.mat')
  %data=compare{1,1};
  rateDiff=[];
  for i=1:length(data)
      if ~isempty(data(i).detail)
          temp=data(i).detail(:,2);
          temp(isnan(temp))=[];
          temp(temp==0)=[];
          rateDiff=[rateDiff;temp];
      end
  end
  mae=mean(rateDiff);
  rmse=sqrt(mean(rateDiff.^2));
end

