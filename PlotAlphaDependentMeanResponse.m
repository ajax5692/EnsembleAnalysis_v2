function [grandAlphaDependentCellDff,f] = PlotAlphaDependentMeanResponse(var1,var2,EnsembleAnalysisParams)

%This function creates the mean df/f curves for the respective alpha values
%alpha*cell*trial*frames

for alphaIndex = 1:size(var2,2)

    for trialIndex = 1:size(var2(alphaIndex).trialNumbers,1)

        for cellIndex = 1:size(var1,1)

            alphaDependentCellDff(cellIndex,trialIndex,:) = var1(cellIndex,var2(alphaIndex).trialNumbers(trialIndex),:);

        end

    end

    grandAlphaDependentCellDff(alphaIndex).cellAndTrialDff = alphaDependentCellDff;
    grandAlphaDependentCellDff(alphaIndex).alphaVal = var2(alphaIndex).alphaValue;

    clear alphaDependentCellDff

end


f = figure;
for alphaIndex = 1:size(var2,2)
    cellAndTrialAveragedDffPerAlpha(alphaIndex,:) = permute(mean(mean(grandAlphaDependentCellDff(alphaIndex).cellAndTrialDff,2),1),[3 2 1])';
    Legend{alphaIndex} = grandAlphaDependentCellDff(alphaIndex).alphaVal;
end

plot(cellAndTrialAveragedDffPerAlpha','Linewidth',3)
hold on
xlim([0 EnsembleAnalysisParams.totalFramesPerUnit])
xregion(EnsembleAnalysisParams.visStimStartFrame,EnsembleAnalysisParams.visStimEndFrame)
legend(Legend)
xlabel('Frame #')
ylabel('∆F/F')
% hleg = legend('show');
% hleg.String(end) = [];