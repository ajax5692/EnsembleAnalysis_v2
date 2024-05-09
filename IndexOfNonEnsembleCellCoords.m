function nonEnsembleCellIndices = IndexOfNonEnsembleCellCoords(nonEnsembleCellCoords,allROIMatrix)


% Find identical sets of coordinates
[~, indices_in_allROIMatrix] = ismember(allROIMatrix', nonEnsembleCellCoords', 'rows');

% Filter out zero indices (which are the coordinates not found)
nonEnsembleCellIndices = find(indices_in_allROIMatrix ~= 0);