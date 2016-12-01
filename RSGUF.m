function [mae]=RSGUF(trainData,testData,afa,beta)
  %��ʽ��dataFormat();%�û�����%%1.�����û�ƫ�þ���%matrix=userPrefrence(data);
  %%2.�ֲھ���
  %�û����ƾ���
  if(exist('UBCF_SIM.mat','file')>0)
      load('UBCF_SIM.mat');
  else
      SIM = SIMMatrix(trainData);
      save  UBCF_SIM.mat SIM;
  end
  %afa ����
  cluster = afaRoughCluster( SIM,afa );
  %��Է��������
  clusterSim=zeros(length(cluster),length(cluster));
  for i=1:length(cluster)
      for j=1:length(cluster)
          if i==j
              clusterSim(i,j)=0;
          else
              clusterSim(i,j)=1-length(intersect(cluster{i},cluster{j}))/length(cluster{i});
          end
      end
  end

  users=trainData(:,1);
  users(1)=[];
  itemsIndex=trainData(1,:);
  itemsIndex(1)=[];
  mae=[];
  for i=1:length(users)
      userid=users(i);
      itemsOrg=testData(testData(:,1)==userid,2:size(testData,2));
      %userPreferenceItems=getPreferenceItems(userid,trainData(2:size(trainData,1),:));%???ʲô��˼
      myPrefer=getPreference(userid,trainData);
      %step1:��s(afa)��ƫ��
      %1.1ȡ�������Ӧ��ƫ�þ���
      neighboruser=cluster{i,1};
      neigborItems=trainData(neighboruser+1,2:size(trainData,2));
      neigborSims=SIM(i,cluster{i,1});
      afaPrefer=caculatePreferWhithItemsAndSims(neigborItems,neigborSims);
      %step2:�������ƶ�
      afasim=personCorrelation(myPrefer,afaPrefer);
      %step3:beta��
      betaCluster=find(clusterSim(i,:)<=beta);
      betaDomain=[];
      betaItems=[];
      for b=1:length(betaCluster)
          if betaCluster(b)==i
              continue;
          end
          betaClusterUser=cluster{betaCluster(b),1};
          for j=1:length(betaClusterUser)
              if isempty(find(neighboruser==betaClusterUser(j)))
                  if isempty(betaDomain)
                      cur=[];
                  else
                      cur=find(betaDomain(:,1)==betaClusterUser(j));
                  end
                  c=clusterSim(i,betaCluster(b));
                  csim=afasim*(1-c);
                  if isempty(cur)
                      tempPrefer=getPreference(betaClusterUser(j),trainData);
                      if ~isempty(tempPrefer)
                          betaDomain=[betaDomain;[betaClusterUser(j),csim]];
                          betaItems=[betaItems;tempPrefer];
                      end
                  else
                      betaDomain(cur,2)=(betaDomain(cur,2)+csim)/2;
                  end
              end
          end
      end
      if isempty(betaItems)
          candidate=afaPrefer;
      else
          neigborItems=[neigborItems;betaItems];
          neigborSims=[neigborSims,betaDomain(:,2)'];
          candidate=caculatePreferWhithItemsAndSims(neigborItems+1,neigborSims);
      end
      [items,index]=sort(candidate,'descend');
      recItems=[index',items'];
      %��������ҵ���Ӧ��itemID
      recItems(:,1)=matchItemid(recItems(:,1),itemsIndex);
      %��MAE
      for i=1:size(itemsOrg,1)
          ind=find(recItems(:,1)==itemsOrg(i,1));
          if ind~=0 & recItems(ind,2)>0
             diff=abs(itemsOrg(i,2)-recItems(ind,2));
             mae=[mae;[userid,itemsOrg(i,1),diff]];
          else
             mae=[mae;[userid,itemsOrg(i,1),NaN]];
          end
      end
  end
end

function prefer=caculatePreferWhithItemsAndSims(items,sims)
  if length(sims)==1
      prefer=items;
      return ;
  end
  if size(sims,1)~=size(items,1)
      sims=sims';
  end
  simMatrix=repmat(sims,1,size(items,2));
  candidateSet=items.*simMatrix;
  simMatrix(candidateSet==0)=0;
  prefer=sum(candidateSet);
  prefer=prefer./sum(simMatrix);
  %���ֻ��һ���ھ��Ƽ�����Ʒ����ȡ�Ĳ����Ƿ���
  for i=1:size(items,2)
      if sum(simMatrix(:,i)>0)<=1
          prefer(i)=0;
      end
  end
  %ȥ��NAN
  prefer(isnan(prefer))=0;
end

function neighborhoods= afaRoughCluster( SIM ,afa)
    %SIM�û�֮��������Ծ���
    %�õ������û��ľ���
    %��ʼ����
    neighborhoods=cell(size(SIM,1),1);
    for i=1:size(SIM,1)
        neighborhood=getUsersByUserSim(i,SIM,afa,-1);
        neighborhoods{i}=[i,neighborhood(:,1)'];
    end
end

function ids=matchItemid(ids,Iids)
  for i=1:length(ids)
      ids(i)=Iids(ids(i));
  end
end
