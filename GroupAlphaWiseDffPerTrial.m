function [dffDataAlphaAndFrameWisePerTrial] = GroupAlphaWiseDffPerTrial(dffDataPooled,alphaDataWithTrialNumbers,EnsembleAnalysisParams)

%This function cuts up the df/f data according to their trial numbers and
%groups them as per their alpha values.

endFrameNumbers = 1:EnsembleAnalysisParams.totalFramesPerUnit:size(dffDataPooled,2);
alphaCounter = 0;

for alphaIndex = 1:size(alphaDataWithTrialNumbers,2)
    
    alphaCounter = alphaCounter + 1;
            
        for trialIndex = 1:size(alphaDataWithTrialNumbers(alphaIndex).trialNumbers,1)
            
            dffDataAlphaAndFrameWisePerTrial(alphaCounter).frameMatrixForAlphaVals(trialIndex,1) = endFrameNumbers(alphaDataWithTrialNumbers(alphaIndex).trialNumbers(trialIndex));
            dffDataAlphaAndFrameWisePerTrial(alphaCounter).alphaVals = alphaDataWithTrialNumbers(alphaIndex).alphaValue;
            
            try
                dffDataAlphaAndFrameWisePerTrial(alphaCounter).frameMatrixForAlphaVals(trialIndex,2) = endFrameNumbers(alphaDataWithTrialNumbers(alphaIndex).trialNumbers(trialIndex) + 1) - 1;
            catch
                dffDataAlphaAndFrameWisePerTrial(alphaCounter).frameMatrixForAlphaVals(trialIndex,2) = size(dffDataPooled,2);
            end
                
        end
end