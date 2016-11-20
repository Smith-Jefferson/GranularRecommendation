 clear;clc;
% % %IBCF单元测试
% matrix=[
% 1,5,3,2.5,0,0,0,0;
% 2,2,2.5,5,2,0,0,0;
% 3,2.5,0,0,4,4.5,0,5;
% 4,5,0,3,4.5,0,4,0;
% 5,4,3,2,4,3.5,4,0
% ];
% %function TestGetItemMatrix
% itemMatrix=getItemMatrix(matrix);
% % itemMatrix 
% % 
% %     5.0000    2.0000    2.5000    5.0000    4.0000
% %     3.0000    2.5000         0         0    3.0000
% %     2.5000    5.0000         0    3.0000    2.0000
% %          0    2.0000    4.0000    4.5000    4.0000
% %          0         0    4.5000         0    3.5000
% %          0         0         0    4.0000    4.0000
% %          0         0    5.0000         0         0
% 
% itemSim=getItemsSimByEuclidean(itemMatrix)
% % itemSim =
% % %item2和item5 或许有问题？？
% %     1.0000    0.1420    0.1555    0.1602    0.1158    0.1424    0.1028
% %     0.1420    1.0000    0.1975    0.1279    0.1433    0.1497         0
% %     0.1555    0.1975    1.0000    0.1404    0.1121    0.1424         0
% %     0.1602    0.1279    0.1404    1.0000    0.1674    0.1818    0.1347
% %     0.1158    0.1433    0.1121    0.1674    1.0000    0.1420    0.2205
% %     0.1424    0.1497    0.1424    0.1818    0.1420    1.0000         0
% %     0.1028         0         0    0.1347    0.2205         0    1.0000
% 
% users=matrix(:,1)';
% for i=1:length(users)
%   userid=users(i)
%   itemsRec=IBCF(userid,itemMatrix,itemSim,10)
% end

data=dataFormat();
userData=userPrefrence(data);
itemMatrix=getItemMatrix(userData);
itemSim=getItemsSimByEuclidean(itemMatrix);

users=userData(2:size(userData,2),1)';
for i=1:length(users)
  userid=users(i)
  itemsRec=IBCF(userid,itemMatrix,itemSim,10)
end




















