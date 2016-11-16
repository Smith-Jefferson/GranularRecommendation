function threshold=getTHRESHOLDFromMatrix(userid,itemMatrix)
    userPreference=itemMatrix(:,userid+1);
    userPreference(userPreference==0)=[];
    threshold=getTHRESHOLDFromPreference(userPreference);
end


