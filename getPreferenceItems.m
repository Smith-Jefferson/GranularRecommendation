function items=getPreferenceItems(userid,matrix)
    items=getPreference(userid,matrix);
    items=find(items~=0);
end