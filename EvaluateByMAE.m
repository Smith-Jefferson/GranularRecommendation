function mae=EvaluateByMAE(itemsRec,itemsOrg)
  mae=0;
  num=0;
  for i=1:size(itemsRec,1)
    idx=itemsOrg(:,1)==itemsRec(i,1);
    if(sum(idx))
      mae=mae+abs(itemsRec(i,2)-itemsOrg(idx,2));
      num=num+1;
    end
  end
  if num~=0
    mae=mae/num;
  end
end



