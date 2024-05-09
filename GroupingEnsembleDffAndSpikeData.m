function [ensembleDff] = GroupingEnsembleDffAndSpikeData(coreSVD,whichEnsemble,dffDataPooled)

%This function groups the dF/F and binary spike data of only ensemble
%cells.

n = size(coreSVD{whichEnsemble,1},1);

for ensembleIndex = 1:n

    try
        ensembleDff(ensembleIndex,:) = dffDataPooled(coreSVD{whichEnsemble,1}(ensembleIndex),:);
    catch %This creates a zero row vector if 'coreSVD{whichEnsemble,1}(ensembleIndex)' > cells detected in dffDataPooled.
          %This can happen if ensemble detection has happened with a different C2S output than what is being currently used.
        ensembleDff(ensembleIndex,:) = 0;
    end
    
end

zeroRowIdx = find(all(ensembleDff == 0, 2) == 1);
ensembleDff(zeroRowIdx,:) = [];