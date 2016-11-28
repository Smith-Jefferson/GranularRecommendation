function RSGUF_Main
  [data,testData]=dataFormat(0.9);
  trainData=userPrefrence(data);
  RSGUF_Magic=[];
%   matlabpool local 2;  
%   parfor i=1:20
      afa=myrandom(0.3,1);
      beta=myrandom(0,0.5);
      mae=RSGUF(trainData,testData,afa,beta);
      maedat=mae(:,3);
      maedat(isnan(maedat))=[];
      RSGUF_Magic=[RSGUF_Magic;[afa,beta,mean(maedat)]];
%   end
%   matlabpool close 
  save RSGUF_Magic.mat RSGUF_Magic;
end

function r=myrandom(a,b)
  r = a + (b-a).*rand(1);
end