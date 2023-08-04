function [cellAndTrialAveragedDffPerAlpha] = PlotAlphaDependentMeanResponse(var1)

%This function creates the mean df/f curves for the respective alpha values


[~, reindex] = sort( str2double( regexp( {var1.alphaVals}, '\d+', 'match', 'once' )));

figure
for alphaIndex = 1:size(var1,2)
    cellAndTrialAveragedDffPerAlpha(alphaIndex,:) = permute(mean(mean(var1...
                                                                (reindex(alphaIndex)).dffData,2),1),[3 2 1])';
    Legend{alphaIndex} = var1(reindex(alphaIndex)).alphaVals;
end

plot(cellAndTrialAveragedDffPerAlpha','Linewidth',3)
legend(Legend)