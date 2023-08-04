function [nonEnsembleDff] = GroupingNonEnsembleDffAndSpikeData(coreSVD,whichEnsemble,dffDataPooled)

%This function groups the dF/F and binary spike data of only non-ensemble
%cells.

cellCounter = 1;


for cellIndex = 1:size(dffDataPooled,1)

    if any(coreSVD{whichEnsemble,1} == cellIndex) == 0
        
        nonEnsembleDff(cellCounter,:) = dffDataPooled(cellIndex,:);
        % nonEnsembleSpikeRaster(cellCounter,:) = allSpikeMatrix(cellIndex,:);
        cellCounter = cellCounter + 1;
        
    else
        continue
    end
end