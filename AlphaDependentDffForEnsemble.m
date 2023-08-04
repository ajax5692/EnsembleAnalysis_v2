function [alphaDependentDffEnsemble] = AlphaDependentDffForEnsemble(dffDataAlphaAndFrameWisePerTrial,grandDatabaseForEnsemblevsNonEnsemble,EnsembleAnalysisParams)

%This function creates a struct called alphaDependentDffEnsemble  with the
%fieldname 'dffData' having the dimensions n*m*p which respectively 
%correspond to the number of cell(n), number of trials(m), and number of 
%frames(p). There is another fieldname 'alphaVals' which indicate which
%alpha group does the data belong to.

ensembleDff = grandDatabaseForEnsemblevsNonEnsemble.EnsembleCellsDff;

for alphaIndex = 1:size(dffDataAlphaAndFrameWisePerTrial,2)
    
    for ensembleCellIndex = 1:size(grandDatabaseForEnsemblevsNonEnsemble.EnsembleCellsDff,1)
        
        for trialIndex = 1:size(dffDataAlphaAndFrameWisePerTrial(alphaIndex).frameMatrixForAlphaVals,1)
            
            dffEnsemble(ensembleCellIndex,trialIndex,:) = ensembleDff(ensembleCellIndex,...
                                                    dffDataAlphaAndFrameWisePerTrial(alphaIndex).frameMatrixForAlphaVals(trialIndex,1)...
                                                    :dffDataAlphaAndFrameWisePerTrial(alphaIndex).frameMatrixForAlphaVals(trialIndex,2));
        
        end
        
    end
    
    alphaDependentDffEnsemble(alphaIndex).dffData = dffEnsemble;
    clear dffEnsemble
    alphaDependentDffEnsemble(1,alphaIndex).alphaVals = dffDataAlphaAndFrameWisePerTrial(alphaIndex).alphaVals;
    
end
