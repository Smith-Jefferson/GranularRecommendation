%构建用户偏好矩阵%matrix=userPrefrence(data)
function [ matrix] = userPrefrence( m )
    users=unique(m(:,1));
    items=unique(m(:,2));
    matrix=zeros(length(users)+1,length(items)+1);
    matrix(2:size(matrix,1),1)=users';
    matrix(1,2:size(matrix,2))=items';
    itemIndex=1;
    for i=1:length(users)
        itemvector=zeros(1,length(items));
        for j=itemIndex:size(m,1)
            if(m(j,1)==users(i))
                it=find(items==m(j,2));
                itemIndex=itemIndex+1;
                if(itemvector(it)<m(j,3))
                    itemvector(it)=m(j,3);
                end
            else
                break
            end
        end
        matrix(i+1,2:length(items)+1)=itemvector;
    end
end

