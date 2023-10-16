function [grandDatabaseForEnsemblevsNonEnsemble,EnsembleAnalysisParams] = SeparateAndGroupEvsNEdffData(EnsembleAnalysisParams)

% This function separates and groups the dF/F and binary spike data into
% Ensemble and Non-Ensemble cohorts. This can then be used for further
% comparison.

coreSVD = EnsembleAnalysisParams.coreSVD;
numLayers = EnsembleAnalysisParams.numLayers;

whichEnsemble = EnsembleAnalysisParams.whichEnsemble;


%Pool the dF/F data
[dffDataPooled,EnsembleAnalysisParams] = PoolDffData(EnsembleAnalysisParams);


f = uifigure;
f.Position(3:4) = [400 100];
d = uiprogressdlg(f,'Title','Running SeparateAndGroupEvsNEdffData.m','Indeterminate','on');
%Get the dF/F and the spike raster for ensemble group
[ensembleDff] = GroupingEnsembleDffAndSpikeData(coreSVD,whichEnsemble,dffDataPooled);

%Get the dF/F and the spike raster for non-ensemble
[nonEnsembleDff] = GroupingNonEnsembleDffAndSpikeData(coreSVD,whichEnsemble,dffDataPooled);

%Cutting the whole trace based of individual units/trials (FOR ENSEMBLE GROUP)
[cutUpEnsembleCellsDff,unitChunks] = TrialWiseDffAndSpikeCutUpEnsemble(EnsembleAnalysisParams,dffDataPooled,ensembleDff);

%Cutting the whole trace based of individual units/trials (FOR NON-ENSEMBLE GROUP)
[cutUpNonEnsembleCellsDff] = TrialWiseDffAndSpikeCutUpNonEnselble(EnsembleAnalysisParams,dffDataPooled,nonEnsembleDff,unitChunks);

close(f)
close(d)
clear f d


grandDatabaseForEnsemblevsNonEnsemble.EnsembleCellsDff = ensembleDff;
grandDatabaseForEnsemblevsNonEnsemble.NonEnsembleCellsDff = nonEnsembleDff;

grandDatabaseForEnsemblevsNonEnsemble.cutUpEnsembleCellsDff = cutUpEnsembleCellsDff;
grandDatabaseForEnsemblevsNonEnsemble.cutUpNonEnsembleCellsDff = cutUpNonEnsembleCellsDff;

