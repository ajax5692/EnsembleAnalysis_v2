function [dffDataPooled,EnsembleAnalysisParams] = PoolDffData(EnsembleAnalysisParams)

%This function pools the dF/F data for all cells.
if isempty(EnsembleAnalysisParams.layerDataPath) == 1

    for layerIndex = 1:EnsembleAnalysisParams.numLayers

        [fileName filePath] = uigetfile('',strcat('Open the layer', " ", num2str(layerIndex)," ",'data that was obtained using the CalciumToSpike GUI'));
        cd(filePath)

        layerData(layerIndex,1) = load(fileName);

        EnsembleAnalysisParams.layerDataPath{1,layerIndex} = fileName;
        EnsembleAnalysisParams.layerDataPath{2,layerIndex} = filePath;

    end

    dffDataPooled = vertcat(layerData(:).deltaff);

else
    for layerIndex = 1:EnsembleAnalysisParams.numLayers
        layerData(layerIndex,1) = load(strcat(EnsembleAnalysisParams.layerDataPath{2,layerIndex},EnsembleAnalysisParams.layerDataPath{1,layerIndex}));
    end
    
    dffDataPooled = vertcat(layerData(:).deltaff);
end