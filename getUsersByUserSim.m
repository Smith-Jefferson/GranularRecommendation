function neighborhood=getUsersByUserSim(userid,SIM,Apha,num)
  neighbor=SIM(userid,:)>=Apha;
  similarty=SIM(userid,neighbor);
  neighborhood=[find(neighbor==true)',similarty'];
  neighborhood(neighborhood(:,1)==userid,:)=[];%����Լ������ƶ�
  if ~isempty(neighborhood) & num~=-1
      neighborhood=sortrows(neighborhood,-2);%���ű�ʾ����
      if(num>length(neighborhood))
          num=size(neighborhood,1);
      end
      neighborhood=neighborhood(1:num,:);
  end
end