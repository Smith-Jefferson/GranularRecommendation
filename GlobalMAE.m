function [ mae,rmse ] = GlobalMAE( compare )
  data=compare{1,1};
  rateDiff=[];
  for i=1:length(data)
      if ~isempty(data(i).detail)
          rateDiff=[rateDiff;data(i).detail];
      end
  end
  rateDiff(isnan(rateDiff))=[];
  mae=mean(rateDiff);
  rmse=sqrt(mean(rateDiff.^2));
end

