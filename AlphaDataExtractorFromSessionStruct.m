function [grandAlphaDataBaseWithTrialNumbers] = AlphaDataExtractorFromSessionStruct(sessionStruct)

%This function extracts the alpha value per trial and groups them together,
%such that the output alphaData contains the trial numbers per alpha group.

for trialIndex = 1:size(sessionStruct,2)    
    alphaValuesTrialWise(trialIndex) = sessionStruct(trialIndex).alpha;    
end
    
uniqueAlpha = unique(alphaValuesTrialWise);

for alphaIndex = 1:size(uniqueAlpha,2)    
   eval(['alpha' num2str(uniqueAlpha(alphaIndex)) ' = find(alphaValuesTrialWise(:) == uniqueAlpha(alphaIndex));'])   
end

clear alphaIndex sessionStruct trialIndex alphaValuesTrialWise

%This part automates the detection of "alpha_" values and their trial
%numbers
S = whos;
varNameArray = {S.name};
clear S

for varNameIndex=1:length(varNameArray)
    if strfind(varNameArray{1,varNameIndex},'alpha') == 1
        tempAlphaData(varNameIndex).alphaValue = varNameArray{1,varNameIndex};
        tempAlphaData(varNameIndex).trialNumbers = eval(varNameArray{1,varNameIndex});
    else
        continue
    end
end

%This part sorts the alpha values in ascending order alongwith their
%corresponding trials
[~, reindex] = sort( str2double( regexp( {tempAlphaData.alphaValue}, '\d+', 'match', 'once' )));

for alphaRestructureIndex = 1:size(tempAlphaData,2)
    grandAlphaDataBaseWithTrialNumbers(alphaRestructureIndex).alphaValue = tempAlphaData(reindex(alphaRestructureIndex)).alphaValue;
    grandAlphaDataBaseWithTrialNumbers(alphaRestructureIndex).trialNumbers = tempAlphaData(reindex(alphaRestructureIndex)).trialNumbers;
end