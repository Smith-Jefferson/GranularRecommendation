function neighborhood=getUsersByUserSim(userid,SIM,Apha,num)
  neighbor=SIM(userid,:)>Apha;
  similarty=SIM(userid,neighbor);
  neighborhood=[find(neighbor==true)',similarty'];
  neighborhood(neighborhood(:,1)==userid,:)=[];%����Լ������ƶ�
  if num~=-1
      neighborhood=sortrows(neighborhood,-2);%���ű�ʾ����
      if(num>length(neighborhood))
          num=length(neighborhood);
      end
      neighborhood=neighborhood(1:num,:);
  end
end