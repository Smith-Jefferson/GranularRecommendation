function userGene=getPreference(userid,userPreference)
    index=find(userPreference(:,1)==userid);
    userGene=userPreference(index,2:size(userPreference,2));
end