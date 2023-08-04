function [cutUpNonEnsembleCellsDff] = TrialWiseDffAndSpikeCutUpNonEnselble(EnsembleAnalysisParams,dffDataPooled,nonEnsembleDff,unitChunks)

%This function cuts up the long dF/F traces and binary spike data as per
%the total number of frames per trial/unit, for only non-ensemble cells.


whichEnsemble = EnsembleAnalysisParams.whichEnsemble;
totalFramesPerUnit = EnsembleAnalysisParams.totalFramesPerUnit;
cellCounter = 1;

for cellIndex = 1:size(dffDataPooled,1)

    try
    
        if any(EnsembleAnalysisParams.coreSVD{whichEnsemble,1} == cellIndex) == 0
            
            for unitIndex = 1:size(unitChunks,2)
            
                if unitIndex < size(unitChunks,2)
    
                cutUpNonEnsembleCellsDff(cellCounter,:) = nonEnsembleDff(cellIndex,unitChunks(unitIndex):unitChunks(unitIndex)+totalFramesPerUnit);
                % cutUpNonEnsembleSpike(cellCounter2,:) = allSpikeMatrix(cellIndex,unitChunks(unitIndex):unitChunks(unitIndex)+totalFramesPerUnit);
                cellCounter = cellCounter + 1;
    
                else
                    continue
                end
            
            end
                    
    
            
        else
            continue
        end

    catch
    end
end