function [nonEnsembleDff] = GroupingNonEnsembleDffAndSpikeData(coreSVD,whichEnsemble,dffDataPooled,poolSVDcoords)

%This function groups the dF/F and binary spike data of only non-ensemble
%cells.

%Load the relevant allROIcoords.mat
[filename,folderpath] = uigetfile('*.mat','Select appropriate allLayerROIspooled.mat file');

cd(folderpath)
load(filename)

nonEnsembleCellCoords = CoordinateSets_CommonVsUnique(poolSVDcoords{whichEnsemble,1},allROIMatrix);
nonEnsembleCellIndices = IndexOfNonEnsembleCellCoords(nonEnsembleCellCoords,allROIMatrix);

cellCounter = 1;


for cellIndex = 1:size(nonEnsembleCellIndices,1)

    nonEnsembleDff(cellCounter,:) = dffDataPooled(nonEnsembleCellIndices(cellIndex),:);
    cellCounter = cellCounter + 1;
        
    else
        continue
    end
end