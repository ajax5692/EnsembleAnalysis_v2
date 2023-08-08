function [grandAlphaDatabaseWithTrialNumbers] = GroupAlphaWiseDffPerTrial(dffDataPooled,grandAlphaDatabaseWithTrialNumbers,EnsembleAnalysisParams)

%This function cuts up the df/f data according to their trial numbers and
%groups them as per their alpha values.

endFrameNumbers = 1:EnsembleAnalysisParams.totalFramesPerUnit:size(dffDataPooled,2);
alphaCounter = 0;

for alphaIndex = 1:size(grandAlphaDatabaseWithTrialNumbers,2)
    
    alphaCounter = alphaCounter + 1;
            
        for trialIndex = 1:size(grandAlphaDatabaseWithTrialNumbers(alphaIndex).trialNumbers,1)
            
            grandAlphaDatabaseWithTrialNumbers(alphaCounter).frameMatrixForAlphaVals(trialIndex,1) = endFrameNumbers(grandAlphaDatabaseWithTrialNumbers(alphaIndex).trialNumbers(trialIndex));
            
            try
                grandAlphaDatabaseWithTrialNumbers(alphaCounter).frameMatrixForAlphaVals(trialIndex,2) = endFrameNumbers(grandAlphaDatabaseWithTrialNumbers(alphaIndex).trialNumbers(trialIndex) + 1) - 1;
            catch
                grandAlphaDatabaseWithTrialNumbers(alphaCounter).frameMatrixForAlphaVals(trialIndex,2) = size(dffDataPooled,2);
            end
                
        end
end