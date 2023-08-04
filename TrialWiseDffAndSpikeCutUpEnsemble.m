function [cutUpEnsembleCellsDff,unitChunks] = TrialWiseDffAndSpikeCutUpEnsemble(EnsembleAnalysisParams,dffDataPooled,ensembleDff)

%This function cuts up the long dF/F traces and binary spike data as per
%the total number of frames per trial/unit, for only ensemble cells.

totalFramesPerUnit = EnsembleAnalysisParams.totalFramesPerUnit;

unitChunks = 1:totalFramesPerUnit:size(dffDataPooled,2);

cellCounter = 1;

for cellIndex = 1:size(ensembleDff,1)
    
    for unitIndex = 1:size(unitChunks,2)
        
        if unitIndex < size(unitChunks,2)
    
        cutUpEnsembleCellsDff(cellCounter,:) = ensembleDff(cellIndex,unitChunks(unitIndex):unitChunks(unitIndex)+totalFramesPerUnit);
        % cutUpEnsembleSpike(cellCounter,:) = allSpikeMatrix(cellIndex,unitChunks(unitIndex):unitChunks(unitIndex)+totalFramesPerUnit);
        cellCounter = cellCounter + 1;
        
        else
            continue
        end
        
    end
end