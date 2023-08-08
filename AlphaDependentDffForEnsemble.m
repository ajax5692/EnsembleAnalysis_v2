function [reshapedEnsembleDff] = AlphaDependentDffForEnsemble(grandDatabaseForEnsemblevsNonEnsemble,EnsembleAnalysisParams)

%This function creates a matrix called reshapedEnsembleDff having the 
%dimensions n*m*p which respectively correspond to the number of cell(n),
%number of trials(m), and number of frames(p).

ensembleDff = grandDatabaseForEnsemblevsNonEnsemble.EnsembleCellsDff;
totalFramesPerUnit = EnsembleAnalysisParams.totalFramesPerUnit;
totalTrials = size(grandDatabaseForEnsemblevsNonEnsemble.EnsembleCellsDff,2)/totalFramesPerUnit;

% Reshaping the ensembleDff matrix to match the total frames per
% trial/unit
for cellIndex = 1:size(ensembleDff,1)
    reshapedEnsembleDff(:,:,cellIndex) = reshape(ensembleDff(cellIndex,:),[totalFramesPerUnit,totalTrials])';
end

reshapedEnsembleDff = permute(reshapedEnsembleDff,[3 1 2]);
