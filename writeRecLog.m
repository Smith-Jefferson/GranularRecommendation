function writeRecLog(userid,recItems)
  record=['user:',num2str(userid),',recommendItem(itemID,recValue):'];
  for i=1:size(recItems,1)
      record=[record,num2str(recItems(i,1)),':',num2str(recItems(i,2))];
      if(i~=size(recItems,1))
          record=[record,','];
      end
  end
  Log(record);
end