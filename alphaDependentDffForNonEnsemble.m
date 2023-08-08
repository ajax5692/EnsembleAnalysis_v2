function [reshapedNonEnsembleDff] = AlphaDependentDffForNonEnsemble(grandDatabaseForEnsemblevsNonEnsemble,EnsembleAnalysisParams)

%This function creates a matrix called reshapedEnsembleDff having the 
%dimensions n*m*p which respectively correspond to the number of cell(n),
%number of trials(m), and number of frames(p).

nonEnsembleDff = grandDatabaseForEnsemblevsNonEnsemble.NonEnsembleCellsDff;
totalFramesPerUnit = EnsembleAnalysisParams.totalFramesPerUnit;
totalTrials = size(grandDatabaseForEnsemblevsNonEnsemble.EnsembleCellsDff,2)/totalFramesPerUnit;

% Reshaping the ensembleDff matrix to match the total frames per
% trial/unit
for cellIndex = 1:size(nonEnsembleDff,1)
    reshapedNonEnsembleDff(:,:,cellIndex) = reshape(nonEnsembleDff(cellIndex,:),[totalFramesPerUnit,totalTrials])';
end

reshapedNonEnsembleDff = permute(reshapedNonEnsembleDff,[3 1 2]);
