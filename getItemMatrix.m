function itemMatrix=getItemMatrix(matrix)
%横坐标为ItemID，纵坐标为userID
  matrix(:,1)=[];
  itemMatrix=matrix';
end
% matrix=[
% 1,5,3,2.5,0,0,0,0;
% 2,2,2.5,5,2,0,0,0;
% 3,2.5,0,0,4,4.5,0,5;
% 4,5,0,3,4.5,0,4,0;
% 5,4,3,2,4,3.5,4,0
% ];
