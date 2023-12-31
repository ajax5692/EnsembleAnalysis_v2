function [grandAlphaDatabaseWithTrialNumbers] = ExtractAndSaveDffAlphaDataWithTrialNumsAndFrameNums(EnsembleAnalysisParams)

%This function creates a matrix containing alpha data with corresponding
%trial numbers and another matrix containing alpha data and corresponding
%starting and ending frame numbers of a trial that would next be used to
%cut up the dF/F traces and binary spike matrices, trialwise and group
%wise, i.e., ensemble vs non-ensemble.


%Load the sessionStruct data containing the timestamps of the behavStruct
%and alpha values
lastBackslashIndex = find(EnsembleAnalysisParams.sessionStructPath == '\', 1, 'last');
cd(EnsembleAnalysisParams.sessionStructPath(1:lastBackslashIndex - 1))
load(EnsembleAnalysisParams.sessionStructPath(lastBackslashIndex + 1:end))


%Create an array of already recorded alpha values
[grandAlphaDatabaseWithTrialNumbers] = AlphaDataExtractorFromSessionStruct(sessionStruct);


%The output of this section can be used to cut up the df/f data according
%to their trial numbers.

dffDataPooled = PoolDffData(EnsembleAnalysisParams);

[grandAlphaDatabaseWithTrialNumbers] = GroupAlphaWiseDffPerTrial(dffDataPooled,grandAlphaDatabaseWithTrialNumbers,EnsembleAnalysisParams);