function RSGIF_Main
  [data,testData]=dataFormat(0.9);
  trainData=userPrefrence(data);
  RSGIF_Magic=[];
  matlabpool local 2;
   for i=1:10
      afa=myrandom(0.5,1);
      beta=myrandom(0,0.5);
      mae=RSGIF(trainData,testData,afa,beta);
      maedat=mae(:,3);
      maedat(isnan(maedat))=[];
      RSGIF_Magic=[RSGIF_Magic;[afa,beta,mean(maedat)]];
  end
  matlabpool close
  save RSGIF_Magic.mat RSGIF_Magic;
end

function r=myrandom(a,b)
  r = a + (b-a).*rand(1);
end
