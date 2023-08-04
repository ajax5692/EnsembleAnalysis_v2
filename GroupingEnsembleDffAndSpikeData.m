function [ensembleDff] = GroupingEnsembleDffAndSpikeData(coreSVD,whichEnsemble,dffDataPooled)

%This function groups the dF/F and binary spike data of only ensemble
%cells.

n = size(coreSVD{whichEnsemble,1},1);

for ensembleIndex = 1:n

    ensembleDff(ensembleIndex,:) = dffDataPooled(coreSVD{whichEnsemble,1}(ensembleIndex),:);
    % ensembleSpikeRaster(ensembleIndex,:) = allSpikeMatrix(coreSVD{whichEnsemble,1}(ensembleIndex),:);
    
end