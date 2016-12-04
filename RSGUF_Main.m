function RSGUF_Main
  [Tdata,TtestData]=dataSplit;
  data=Tdata.ML_100_20;
  testData=TtestData.ML_100_20;
  trainData=userPrefrence(data);
  RSGUF_Magic=[];
%   matlabpool 2;  
%   parfor i=1:2
      afa=0.4;
      beta=myrandom(0,0.3);
      mae=RSGUF(trainData,testData,afa,beta);
      maedat=mae(:,3);
      maedat(isnan(maedat))=[];
      RSGUF_Magic=[RSGUF_Magic;[afa,beta,mean(maedat)]]
%    end
%   matlabpool close 
 save RSGUF_Magic.mat RSGUF_Magic;
end

function r=myrandom(a,b)
  r = a + (b-a).*rand(1);
end