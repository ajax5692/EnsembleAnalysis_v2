function [grandDatabaseForEnsemblevsNonEnsemble] = SeparateAndGroupEvsNEdffData(EnsembleAnalysisParams)

% This function separates and groups the dF/F and binary spike data into
% Ensemble and Non-Ensemble cohorts. This can then be used for further
% comparison.

coreSVD = EnsembleAnalysisParams.coreSVD;
numLayers = EnsembleAnalysisParams.numLayers;

whichEnsemble = EnsembleAnalysisParams.whichEnsemble;


%Pool the dF/F data

dffDataPooled = PoolDffData(numLayers);


f = waitbar(0, 'Starting');

%Get the dF/F and the spike raster for ensemble group
waitbar(1/4, f, sprintf('Progress: Part 1 Running'));
[ensembleDff] = GroupingEnsembleDffAndSpikeData(coreSVD,whichEnsemble,dffDataPooled);

%Get the dF/F and the spike raster for non-ensemble
waitbar(2/4, f, sprintf('Progress: Part 2 Running'));
[nonEnsembleDff] = GroupingNonEnsembleDffAndSpikeData(coreSVD,whichEnsemble,dffDataPooled);

%Cutting the whole trace based of individual units/trials (FOR ENSEMBLE GROUP)
waitbar(3/4, f, sprintf('Progress: Part 3 Running'));
[cutUpEnsembleCellsDff,unitChunks] = TrialWiseDffAndSpikeCutUpEnsemble(EnsembleAnalysisParams,dffDataPooled,ensembleDff);

%Cutting the whole trace based of individual units/trials (FOR NON-ENSEMBLE GROUP)
waitbar(4/4, f, sprintf('Progress: Part 4 Running'));
[cutUpNonEnsembleCellsDff] = TrialWiseDffAndSpikeCutUpNonEnselble(EnsembleAnalysisParams,dffDataPooled,nonEnsembleDff,unitChunks);

close(f)

grandDatabaseForEnsemblevsNonEnsemble.EnsembleCellsDff = ensembleDff;
grandDatabaseForEnsemblevsNonEnsemble.NonEnsembleCellsDff = nonEnsembleDff;

grandDatabaseForEnsemblevsNonEnsemble.cutUpEnsembleCellsDff = cutUpEnsembleCellsDff;
grandDatabaseForEnsemblevsNonEnsemble.cutUpNonEnsembleCellsDff = cutUpNonEnsembleCellsDff;

