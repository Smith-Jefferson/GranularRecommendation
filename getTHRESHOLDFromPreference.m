function threshold=getTHRESHOLDFromPreference(userPreference)
    threshold=mean(userPreference)+std(userPreference);
end