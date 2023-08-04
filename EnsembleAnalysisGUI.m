function varargout = EnsembleAnalysisGUI(varargin)
% ENSEMBLEANALYSISGUI MATLAB code for EnsembleAnalysisGUI.fig
%      ENSEMBLEANALYSISGUI, by itself, creates a new ENSEMBLEANALYSISGUI or raises the existing
%      singleton*.
%
%      H = ENSEMBLEANALYSISGUI returns the handle to a new ENSEMBLEANALYSISGUI or the handle to
%      the existing singleton*.
%
%      ENSEMBLEANALYSISGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENSEMBLEANALYSISGUI.M with the given input arguments.
%
%      ENSEMBLEANALYSISGUI('Property','Value',...) creates a new ENSEMBLEANALYSISGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EnsembleAnalysisGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EnsembleAnalysisGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EnsembleAnalysisGUI

% Last Modified by GUIDE v2.5 03-Aug-2023 15:08:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EnsembleAnalysisGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @EnsembleAnalysisGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before EnsembleAnalysisGUI is made visible.
function EnsembleAnalysisGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EnsembleAnalysisGUI (see VARARGIN)

% Choose default command line output for EnsembleAnalysisGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

warning off

set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.AlphaDataExtractor,'Enable','off')
set(handles.ensembleButton,'Enable','on')
set(handles.plotEnsembleButton,'Enable','off')

EnsembleAnalysisParams.originalCodePath = uigetdir('','Define the code repository path first');
cd(EnsembleAnalysisParams.originalCodePath)
load('ensembleAnalysisParams.mat')
EnsembleAnalysisParams.isSVDOutputLoaded = 0;
set(handles.numLayersUserInput,'String',EnsembleAnalysisParams.numLayers)
set(handles.frameRate,'String',EnsembleAnalysisParams.frameRate)
set(handles.whichEnsemble,'String',EnsembleAnalysisParams.whichEnsemble)
set(handles.totalFramesPerUnit,'String',EnsembleAnalysisParams.totalFramesPerUnit)

save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')

% UIWAIT makes EnsembleAnalysisGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EnsembleAnalysisGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
load('ensembleAnalysisParams.mat')
cd(EnsembleAnalysisParams.originalCodePath)


% --- Executes on button press in loadSVDoutput.
function loadSVDoutput_Callback(hObject, eventdata, handles)
% hObject    handle to loadSVDoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
try
    while EnsembleAnalysisParams.isSVDOutputLoaded == 0;
        [fileName filePath] = uigetfile('','Open the appropriate OUT.mat file');
        cd(filePath)
        load(fileName)
        EnsembleAnalysisParams.coreSVD = OUT.coreSVD;
        cd(EnsembleAnalysisParams.originalCodePath)
        save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
        EnsembleAnalysisParams.isSVDOutputLoaded = 1;
    end
    
    EnsembleAnalysisParams.isSVDOutputLoaded = 0;
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
        
    set(handles.loadSVDoutput,'Enable','off')
    % set(handles.calculateSpike,'Enable','on')
    % set(handles.calculateDff,'BackgroundColor',[0.9290 0.6940 0.1250]);
    set(handles.loadSVDoutputStatus,'String','SVD OUT loaded','ForegroundColor','green','BackgroundColor','black')
    cd(EnsembleAnalysisParams.originalCodePath)
    set(handles.EvsNEdFFseparator,'Enable','on')
    

catch
    disp('SVD Output loading interrupted')
    resetGUI_Callback(hObject, eventdata, handles)
end



function numLayersUserInput_Callback(hObject, eventdata, handles)
% hObject    handle to numLayersUserInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numLayersUserInput as text
%        str2double(get(hObject,'String')) returns contents of numLayersUserInput as a double
load('ensembleAnalysisParams.mat')
EnsembleAnalysisParams.numLayers = str2double(get(hObject,'String'));
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')


% --- Executes during object creation, after setting all properties.
function numLayersUserInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numLayersUserInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EvsNEdFFseparator.
function EvsNEdFFseparator_Callback(hObject, eventdata, handles)
% hObject    handle to EvsNEdFFseparator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load('ensembleAnalysisParams.mat')
    while EnsembleAnalysisParams.isEvsNEgroupingDone == 0;
        set(handles.EvsNEseparationStatus,'String','E vs NE grouping running','ForegroundColor','red','BackgroundColor','black')
        [grandDatabaseForEnsemblevsNonEnsemble] = SeparateAndGroupEvsNEdffData(EnsembleAnalysisParams);
        EnsembleAnalysisParams.isEvsNEgroupingDone = 1;
    end
    saveFilePath = uigetdir('','Select the folder location to store the analyzed data');
    cd(saveFilePath)
    filter = {'*.mat'};
    [saveFileName,saveFilePath] = uiputfile(filter,'Specify file name to save analyzed data');
    save(saveFileName,'grandDatabaseForEnsemblevsNonEnsemble')
    cd(EnsembleAnalysisParams.originalCodePath)
    EnsembleAnalysisParams.isEvsNEgroupingDone = 0;
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')

    set(handles.EvsNEdFFseparator,'Enable','off')
    set(handles.EvsNEseparationStatus,'String','E vs NE grouping done','ForegroundColor','green','BackgroundColor','black')
    set(handles.AlphaDataExtractor,'Enable','on')
    cd(EnsembleAnalysisParams.originalCodePath)

catch
    disp('Ensemble vs Non-ensemble data group separation inturrupted')
    resetGUI_Callback(hObject, eventdata, handles)
end



function whichEnsemble_Callback(hObject, eventdata, handles)
% hObject    handle to whichEnsemble (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of whichEnsemble as text
%        str2double(get(hObject,'String')) returns contents of whichEnsemble as a double
load('ensembleAnalysisParams.mat')
EnsembleAnalysisParams.whichEnsemble = str2double(get(hObject,'String'));
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')


% --- Executes during object creation, after setting all properties.
function whichEnsemble_CreateFcn(hObject, eventdata, handles)
% hObject    handle to whichEnsemble (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frameRate_Callback(hObject, eventdata, handles)
% hObject    handle to frameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frameRate as text
%        str2double(get(hObject,'String')) returns contents of frameRate as a double
load('ensembleAnalysisParams.mat')
EnsembleAnalysisParams.frameRate = str2double(get(hObject,'String'));
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')


% --- Executes during object creation, after setting all properties.
function frameRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resetGUI.
function resetGUI_Callback(hObject, eventdata, handles)
% hObject    handle to resetGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.loadSVDoutput,'Enable','on')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.loadSVDoutputStatus,'String','Not yet loaded','ForegroundColor','red')
set(handles.EvsNEseparationStatus,'String','Not yet done','ForegroundColor','red')


% --- Executes on button press in resetLoadSVDout.
function resetLoadSVDout_Callback(hObject, eventdata, handles)
% hObject    handle to resetLoadSVDout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.loadSVDoutput,'Enable','on')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.loadSVDoutputStatus,'String','Not yet loaded','ForegroundColor','red')
set(handles.EvsNEseparationStatus,'String','Not yet done','ForegroundColor','red')


% --- Executes on button press in resetGroupEvsNEdata.
function resetGroupEvsNEdata_Callback(hObject, eventdata, handles)
% hObject    handle to resetGroupEvsNEdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.loadSVDoutput,'Enable','off')
set(handles.EvsNEdFFseparator,'Enable','on')
set(handles.EvsNEseparationStatus,'String','Not yet done','ForegroundColor','red')



function totalFramesPerUnit_Callback(hObject, eventdata, handles)
% hObject    handle to totalFramesPerUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totalFramesPerUnit as text
%        str2double(get(hObject,'String')) returns contents of totalFramesPerUnit as a double
load('ensembleAnalysisParams.mat')
EnsembleAnalysisParams.totalFramesPerUnit = str2double(get(hObject,'String'));
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')


% --- Executes during object creation, after setting all properties.
function totalFramesPerUnit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totalFramesPerUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AlphaDataExtractor.
function AlphaDataExtractor_Callback(hObject, eventdata, handles)
% hObject    handle to AlphaDataExtractor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
[alphaDataWithTrialNumbers,dffDataAlphaAndFrameWisePerTrial] = ExtractAndSaveDffAlphaDataWithTrialNumsAndFrameNums(EnsembleAnalysisParams);
saveFilePath = uigetdir('','Select the location to save the analyzed data');
cd(saveFilePath)
filter = {'*.mat'};
[saveFileName,saveFilePath] = uiputfile(filter,'Specify file name to save analyzed data');
save(saveFileName, 'alphaDataWithTrialNumbers','dffDataAlphaAndFrameWisePerTrial')
set(handles.AlphaDataExtractor,'Enable','off')
set(handles.ensembleButton,'Enable','on')
set(handles.alphaDataExtractionStatus,'String','Done','ForegroundColor','green','BackgroundColor','black')
cd(EnsembleAnalysisParams.originalCodePath)

% --- Executes on button press in resetAlphaDataExtraction.
function resetAlphaDataExtraction_Callback(hObject, eventdata, handles)
% hObject    handle to resetAlphaDataExtraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.loadSVDoutput,'Enable','off')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.AlphaDataExtractor,'Enable','on')
set(handles.alphaDataExtractionStatus,'String','Not yet done','ForegroundColor','red')


% --- Executes on button press in ensembleButton.
function ensembleButton_Callback(hObject, eventdata, handles)
% hObject    handle to ensembleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
[fileName,filePath] = uigetfile('*.mat','Select both of the saved files','MultiSelect', 'on');
cd(filePath)
for fileIndex=1:size(fileName,2)
    load(fileName{1,fileIndex})
end
cd(EnsembleAnalysisParams.originalCodePath)
[alphaDependentDffEnsemble] = AlphaDependentDffForEnsemble(dffDataAlphaAndFrameWisePerTrial,...
                                    grandDatabaseForEnsemblevsNonEnsemble,EnsembleAnalysisParams);
saveFilePath = uigetdir('','Select the location to save the analyzed data');
cd(saveFilePath)
filter = {'*.mat'};
[saveFileName,saveFilePath] = uiputfile(filter,'Specify file name to save analyzed data');
save(saveFileName, 'alphaDependentDffEnsemble')
set(handles.ensembleButton,'Enable','off')
set(handles.ensembleStatus,'String','Done','ForegroundColor','green','BackgroundColor','black')
set(handles.plotEnsembleButton,'Enable','on')
set(handles.plotEnsembleButton,'BackgroundColor','green')
cd(EnsembleAnalysisParams.originalCodePath)

% --- Executes on button press in resetEnsemble.
function resetEnsemble_Callback(hObject, eventdata, handles)
% hObject    handle to resetEnsemble (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.loadSVDoutput,'Enable','off')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.AlphaDataExtractor,'Enable','off')
set(handles.ensembleButton,'Enable','on')
set(handles.ensembleStatus,'String','Not yet done','ForegroundColor','red')


% --- Executes on button press in plotEnsembleButton.
function plotEnsembleButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotEnsembleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
[fileName filePath] = uigetfile('*.mat','Select the analyzed alpha dependent ensemble data');
cd(filePath)
load(fileName)
[cellAndTrialAveragedDffPerAlpha] = PlotAlphaDependentMeanResponse(alphaDependentDffEnsemble);
saveFilePath = uigetdir('','Select the location to save the analyzed data');
cd(saveFilePath)
filter = {'*.mat'};
[saveFileName,saveFilePath] = uiputfile(filter,'Specify file name to save analyzed data');
save(saveFileName, 'cellAndTrialAveragedDffPerAlpha')
cd(EnsembleAnalysisParams.originalCodePath)