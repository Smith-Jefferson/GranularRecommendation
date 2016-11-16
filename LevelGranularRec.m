function [result]=LevelGranularRec(trainData,testData,num,support)
  if(exist('UBCF_SIM.mat','file')>0)
      load('UBCF_SIM.mat');
  else
      SIM = SIMMatrix(trainData);
      save  UBCF_SIM.mat SIM;
  end
  if(exist('Granular_RoughData.mat','file')>0)
      load('Granular_RoughData.mat');
  else
      RoughData = RoughClusterWithScore( SIM,trainData,support );
      save  Granular_RoughData.mat RoughData;
  end
  users=trainData(:,1);
  users(1)=[];
  Apha=support;
  numNeighor=30;
  result=zeros(length(users),6);
  for i=1:length(users)
      userid=users(i);
      itemsOrg=testData(testData(:,1)==userid,2:size(testData,2));
      userPreferenceItems=getPreferenceItems(userid,trainData(2:size(trainData,1),:));
       [itemsRec2,mae2,compare2]=UBCF(userid,trainData,SIM,-1,Apha,numNeighor,itemsOrg);

      [itemsRec1,mae1,compare1]=GranularUBCF(userid,userPreferenceItems,RoughData,SIM,-1,Apha,numNeighor,itemsOrg);
     [itemsRec,newmae] =rescore(itemsRec1,mae1,compare1,itemsRec2,mae2,compare2,userid,users,itemsOrg);
      THRESHOLD=getTHRESHOLDFromPreference(userPreferenceItems);
      result(i,:)=[userid,newmae,EvaluateParam(itemsRec(1:num,:),itemsOrg,THRESHOLD),mae];
  end
end

function [itemsRec,mae] =rescore(itemsRec1,mae1,compare1,itemsRec2,mae2,compare2,userid,users,testItems)
    if(exist('init.mat','file')>0)
       load('init.mat');%变量是x
    else
        x=zeros(1,length(users));
    end
    intial=x(userid);
    if intial==0
       intial=mae2/mae1+mae2;
    end
    dlx=compare1.detail(:,2)>0 & compare2.detail(:,2)>0;
    it=mean(compare2.detail(dlx,2)./(compare1.detail(dlx,2)+compare2.detail(dlx,2)));
    begin=min(intial,min(mae2/(mae1+mae2),it));
    last=max(intial,max(mae2/(mae1+mae2),it));
    
    premae=min(mae1,mae2);currentmae=0;
    preIntail=intial;
    step=0.1;
    itemsRec1=sortrows(itemsRec1,1);
    itemsRec2=sortrows(itemsRec2,1);
    recs(:,1)=itemsRec1(:,1);
    while begin<=last
        recs(:,2)=intial.*itemsRec1(:,2)+(1-intial).*itemsRec2(:,2);
        currentmae=maeTest(recs,testItems);
        if currentmae<min(mae1,mae2) || abs(currentmae-premae)<0.01
            intial=preIntail;
            break;
        else
            itemsRec=recs;
        end
        premae=currentmae;
        preIntail= intial;
        if rand(1)>0.5
            last=last-step;
            intial=last;
        else
            begin=begin+step;
            intial=begin;
        end
    end
    x(userid)=intial;
    save init.mat x;
  end

  
  function mae=maeTest(recItems,testItems)
 %计算MAE
  mae=0;
  if size(testItems,1)>0
      count=0;
      for i=1:size(testItems,1)
          ind=find(recItems(:,1)==testItems(i,1));
          if (ind~=0 & recItems(ind,2)~=0)
              diff=abs(testItems(i,2)-recItems(ind,2));
              mae=mae+diff;
              count=count+1;
          end
      end
      if count<=0
          mae=0;
      else
          mae=mae/count;
      end
  end
end