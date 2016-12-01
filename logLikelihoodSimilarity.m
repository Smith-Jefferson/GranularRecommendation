function sim=logLikelihoodSimilarity(X,Y)
  %k11:X,Y共有的，K22X,Y都没有的的数量，K12表示Y有X没有的的数量，K21表示X有Y没有的的数量
  k22 = 0; k21 = k22; k12 = k21; k11 = k12;
  for i=1:length(X)
    if X(i)==0 && Y(i)==0
      k22=k22+1;
    elseif X(i)~=0 && Y(i)~=0
      k11=k11+1;
    elseif X(i)~=0 && Y(i)==0
      k21=k21+1;
    else
      k12=k12+1;
    end
  end
  if k11==0
      sim=0;
      return;
  end
  sim=1-1/(1+logLikelihoodRatio(k11,k12,k21,k22));
end
function sim=logLikelihoodRatio(k11,k12,k21,k22)
  rowEntropy = entropy2(k11 + k12, k21 + k22);
  columnEntropy = entropy2(k11 + k21, k12 + k22);
  matrixEntropy = entropy4(k11, k12, k21, k22);
  if rowEntropy + columnEntropy < matrixEntropy
    sim =0.0;
  else
    sim = 2 * (rowEntropy + columnEntropy -matrixEntropy);
  end
end

function result=entropy2(a,b)
   result= xLogX(a + b) - xLogX(a) - xLogX(b);
end

function result=entropy4(a,b,c,d)
   result= xLogX(a + b + c + d) - xLogX(a) - xLogX(b) - xLogX(c) - xLogX(d);
end

function result=xLogX(x)
    if x==0
        result=0.0;
    else
        result=x*log(x);
    end
end

function result=entropy(elements)
  sumE =sum(elements);
  result = 0.0;
  for i=1:length(elements)
    x=elements(i);
    if x < 0
        error('Should not have negative count for entropy computation');
        return;
    end
    zeroFlag=0;
    if x==0
      zeroFlag=1;
    end
    result=result+x*log((x+zeroFlag)/sumE);
  end
  result= -result;
end
