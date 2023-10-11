function [cellWiseAlphaDependentTrialAveragedResponse] = Ensemble_CellWiseResponseToAlphaTrialAveraged(reshapedEnsembleDff,grandAlphaDatabaseWithTrialNumbers,EnsembleAnalysisParams)

%The output of this function is a 3D vector, with dimensions n*m*p, where n
%indicates the cells belonging to the ensemble, m indicated the frame
%numbers and p indicates the alpha value.


for alphaIndex = 1:size(grandAlphaDatabaseWithTrialNumbers,2)

    for trialIndex = 1:size(grandAlphaDatabaseWithTrialNumbers(alphaIndex).trialNumbers,1)

        for cellIndex = 1:size(reshapedEnsembleDff,1)

            alphaDependentCellDff(cellIndex,trialIndex,:) = reshapedEnsembleDff(cellIndex,...
                                                                 grandAlphaDatabaseWithTrialNumbers(alphaIndex).trialNumbers(trialIndex),:);

        end

    end

    cellWiseAlphaDependentTrialAveragedResponse(:,:,alphaIndex) = permute(mean(alphaDependentCellDff,2),[1 3 2]);

end


saveLocationDir = uigetdir();
cd(saveLocationDir)
save('CellWiseAlphaDependentTrialAveragedResponse.mat','cellWiseAlphaDependentTrialAveragedResponse')