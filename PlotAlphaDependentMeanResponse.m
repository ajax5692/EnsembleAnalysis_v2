function [grandAlphaDependentCellDff,f] = PlotAlphaDependentMeanResponse(var1,var2,EnsembleAnalysisParams)

%This function creates the mean df/f curves for the respective alpha values
%alpha*cell*trial*frames

visStimStart = EnsembleAnalysisParams.visStimStartFrame;
visStimEnd = EnsembleAnalysisParams.visStimEndFrame;

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
fill([visStimStart visStimEnd visStimEnd visStimStart],[-0.05 -0.05 0.25 0.25],[0.3 0.75 0.93],'EdgeColor','none','FaceAlpha', 0.35,'HandleVisibility','off')
hold on
for alphaIndex = 1:size(var2,2)
    cellAndTrialAveragedDffPerAlpha(alphaIndex,:) = permute(mean(mean(grandAlphaDependentCellDff(alphaIndex).cellAndTrialDff,2),1),[3 2 1])';
    Legend{alphaIndex} = grandAlphaDependentCellDff(alphaIndex).alphaVal;
end

plot(cellAndTrialAveragedDffPerAlpha','Linewidth',3)
xlim([0 EnsembleAnalysisParams.totalFramesPerUnit])
try
    xregion(EnsembleAnalysisParams.visStimStartFrame,EnsembleAnalysisParams.visStimEndFrame)
catch
   ylim([-0.05 0.25]);
end
legend(Legend)
xlabel('Frame #')
ylabel('∆F/F')
% hleg = legend('show');
% hleg.String(end) = [];