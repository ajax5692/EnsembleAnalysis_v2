function alphaDependentDffForNonEnsemble

%This part creates a struct with the fieldname 'dffData' having the
%dimensions n*m*p which respectively correspond to the number of cell(n),
%number of trials(m), and number of frames(p). There is another fieldname
%'alphaVals' which indicate which alpha group does the data belong to.

for alphaIndex = 1:size(alphaStruct,2)
    
    for nonEnsembleCellIndex = 1:size(nonEnsembleDff,1)
        
        for trialIndex = 1:size(alphaStruct(alphaIndex).frameMatrixForAlphaVals,1)
            
            dffNonEnsemble(nonEnsembleCellIndex,trialIndex,:) = nonEnsembleDff(nonEnsembleCellIndex,...
                                                    alphaStruct(alphaIndex).frameMatrixForAlphaVals(trialIndex,1)...
                                                    :alphaStruct(alphaIndex).frameMatrixForAlphaVals(trialIndex,2));
        
        end
        
    end
    
    alphaDependentDffNonEnsemble(alphaIndex).dffData = dffNonEnsemble;
    clear dffNonEnsemble
    alphaDependentDffNonEnsemble(1,alphaIndex).alphaVals = alphaStruct(alphaIndex).alphaVals;
    
end


%This part creates the mean df/f curves for the respective alpha values
[~, reindex] = sort( str2double( regexp( {alphaStruct.alphaVals}, '\d+', 'match', 'once' )));

figure
for alphaIndex = 1:size(alphaDependentDffNonEnsemble,2)
    cellAndTrialAveragedDffPerAlphaNonEnsemble(alphaIndex,:) = permute(nanmean(nanmean(alphaDependentDffNonEnsemble...
                                                                (reindex(alphaIndex)).dffData,2),1),[3 2 1])';
    Legend_NE{alphaIndex} = alphaDependentDffNonEnsemble(reindex(alphaIndex)).alphaVals;
end

plot(cellAndTrialAveragedDffPerAlphaNonEnsemble','Linewidth',3)
legend(Legend_NE)

