function [aucMatrixEnsemble,aucMatrixNonEnsemble] = AucMeasurementAndComparisonBetweenEnsembleVsNonEnsemble(startFrameNum,endFrameNum,grandAlphaDependentCellDff_E,grandAlphaDependentCellDff_NE)


for alphaIndex = 1:size(grandAlphaDependentCellDff_E,2)

    %For ensembles
    trialAveragedDffPerAlphaEnsemble(alphaIndex).trialAveragedDffData = permute(nanmean(grandAlphaDependentCellDff_E(alphaIndex).cellAndTrialDff,2),[1 3 2]);
    trialAveragedDffPerAlphaEnsemble(alphaIndex).alphaVals = grandAlphaDependentCellDff_E(alphaIndex).alphaVal;
    
    for cellIndex = 1:size(trialAveragedDffPerAlphaEnsemble(alphaIndex).trialAveragedDffData,1)
        
        aucE(cellIndex,1) = trapz(trialAveragedDffPerAlphaEnsemble(alphaIndex).trialAveragedDffData(cellIndex,startFrameNum:endFrameNum));
        
    end
    
    cellAndTrialAveragedDffPerAlphaEnsemble(alphaIndex,:) = nanmean(trialAveragedDffPerAlphaEnsemble(alphaIndex).trialAveragedDffData,1);

    aucMatrixEnsemble(alphaIndex).acrossAlphaVals = aucE;
    aucMatrixEnsemble(alphaIndex).meanValue = trapz(cellAndTrialAveragedDffPerAlphaEnsemble(alphaIndex,startFrameNum:endFrameNum));
    aucMatrixEnsemble(alphaIndex).standardDeviation = std(aucMatrixEnsemble(alphaIndex).acrossAlphaVals);
    aucMatrixEnsemble(alphaIndex).SEM = aucMatrixEnsemble(alphaIndex).standardDeviation/sqrt(size(aucMatrixEnsemble(alphaIndex).acrossAlphaVals,1));
    aucMatrixEnsemble(alphaIndex).alphaVals = trialAveragedDffPerAlphaEnsemble(alphaIndex).alphaVals;
    clear aucE
    
    
    
    %For non ensembles
    trialAveragedDffPerAlphaNonEnsemble(alphaIndex).trialAveragedDffData = permute(nanmean(grandAlphaDependentCellDff_NE(alphaIndex).cellAndTrialDff,2),[1 3 2]);
    trialAveragedDffPerAlphaNonEnsemble(alphaIndex).alphaVals = grandAlphaDependentCellDff_NE(alphaIndex).alphaVal;
   
    for cellIndex = 1:size(trialAveragedDffPerAlphaNonEnsemble(alphaIndex).trialAveragedDffData,1)
        
        aucNE(cellIndex,1) = trapz(trialAveragedDffPerAlphaNonEnsemble(alphaIndex).trialAveragedDffData(cellIndex,47:87));
        
    end

    cellAndTrialAveragedDffPerAlphaNonEnsemble(alphaIndex,:) = nanmean(trialAveragedDffPerAlphaNonEnsemble(alphaIndex).trialAveragedDffData,1);
       
    aucMatrixNonEnsemble(alphaIndex).acrossAlphaVals = aucNE;
    aucMatrixNonEnsemble(alphaIndex).meanValue = trapz(cellAndTrialAveragedDffPerAlphaNonEnsemble(alphaIndex,47:87));
    aucMatrixNonEnsemble(alphaIndex).standardDeviation = std(aucMatrixNonEnsemble(alphaIndex).acrossAlphaVals);
    aucMatrixNonEnsemble(alphaIndex).SEM = aucMatrixNonEnsemble(alphaIndex).standardDeviation/sqrt(size(aucMatrixNonEnsemble(alphaIndex).acrossAlphaVals,1));
    aucMatrixNonEnsemble(alphaIndex).alphaVals = trialAveragedDffPerAlphaNonEnsemble(alphaIndex).alphaVals;
    clear aucNE
    
end


%This is required to plot the bar graph accordingly
for ii=1:alphaIndex
    yE(ii) = aucMatrixEnsemble(ii).meanValue;
    yNE(ii) = aucMatrixNonEnsemble(ii).meanValue;
    
    semE(ii) = aucMatrixEnsemble(ii).SEM;
    semNE(ii) = aucMatrixNonEnsemble(ii).SEM;
    
    Legend_barPlot{ii} = aucMatrixEnsemble(ii).alphaVals;
end

groupedBar =[yE;yNE];
groupedSEM = [semE;semNE];

figure
bar(groupedBar)
hold on

[ngroups, nbars] = size(groupedBar);
groupwidth = min(0.8, nbars/(nbars + 1.5));
for ii = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*ii-1) * groupwidth / (2*nbars);
    errorbar(x, groupedBar(:,ii), groupedSEM(:,ii), 'k', 'linestyle', 'none');
end
set(gca,'XTickLabel',{'Ensemble','Non-Ensemble'});
ylabel('AUC')
legend(Legend_barPlot)
title('Comparison of AUC values for Ensemble vs Non-Ensemble cells in group#1 across different alpha values (m998, 2022-12-14)')

hold off

% %This is to check for statistical differences across groups of alpha values
% for ii=1:8
%     grandAucMatricE(:,ii) = aucMatrixEnsemble(ii).acrossAlphaVals;
%     grandAucMatricNE(:,ii) = aucMatrixNonEnsemble(ii).acrossAlphaVals;
% end
% 
% %Check if the data is normally distrubuted. h=1 means it is NOT normally
% %distributed
% h = kstest(grandAucMatricE)
% h1 = kstest(grandAucMatricNE)
% 
% %If the data is NOT normally distributed, perform Kruskal-Wallis test
% [p,tbl,stats] = kruskalwallis(grandAucMatricE);
% [p1,tbl1,stats1] = kruskalwallis(grandAucMatricNE);
% 
% 
% c = multcompare(stats);
% c1 = multcompare(stats1);
% 
% KWtestresultE(:,1) = c(:,1); %This indicates the first group
% KWtestresultE(:,2) = c(:,2); %This indicates the second group
% KWtestresultE(:,3) = c(:,6); %This indicates the p value between the groups along the row
% 
% KWtestresultNE(:,1) = c1(:,1); %This indicates the first group
% KWtestresultNE(:,2) = c1(:,2); %This indicates the second group
% KWtestresultNE(:,3) = c1(:,6); %This indicates the p value between the groups along the row

