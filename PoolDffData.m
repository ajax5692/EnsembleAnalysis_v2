function dffDataPooled = PoolDffData(numLayers)

%This function pools the dF/F data for all cells.

for layerIndex = 1:numLayers

    [fileName filePath] = uigetfile('',strcat('Open the layer', " ", num2str(layerIndex)," ",'analyzed data using the CalciumToSpike GUI'));
    cd(filePath)
           
    layerData(layerIndex,1) = load(fileName);
        
end
    
dffDataPooled = vertcat(layerData(:).deltaff);