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

% Last Modified by GUIDE v2.5 08-Aug-2023 14:43:06

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

set(handles.loadSVDoutput,'Enable','off')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.AlphaDataExtractor,'Enable','off')
set(handles.ensembleButton,'Enable','off')
set(handles.nonEnsembleButton,'Enable','off')
set(handles.loadGrandAlphaDatabaseButton,'Enable','off')
set(handles.loadReshapedEnsembleDffButton,'Enable','off')
set(handles.loadReshapedN_EnsembleDffButton,'Enable','off')
set(handles.plotEnsembleButton,'Enable','off')
set(handles.plotNonEnsembleButton,'Enable','off')


load('ensembleAnalysisParams.mat')
EnsembleAnalysisParams.saveAnalyzedData = 0;
EnsembleAnalysisParams.isSaveDataLocationSet = 0;
EnsembleAnalysisParams.isSVDOutputLoaded = 0;
EnsembleAnalysisParams.isGrandAlphaDatabaseLoaded = 0;
EnsembleAnalysisParams.isReshapedEnsembleDffLoaded = 0;
EnsembleAnalysisParams.isReshapedNonEnsembleDffLoaded = 0;
EnsembleAnalysisParams.isSaveDataLocationSet = 0;
EnsembleAnalysisParams.isAlphaDataExtracted = 0;
EnsembleAnalysisParams.isEnsembleDone = 0;
EnsembleAnalysisParams.isNonEnsembleDone = 0;
set(handles.numLayersUserInput,'String',EnsembleAnalysisParams.numLayers)
set(handles.frameRate,'String',EnsembleAnalysisParams.frameRate)
set(handles.whichEnsemble,'String',EnsembleAnalysisParams.whichEnsemble)
set(handles.totalFramesPerUnit,'String',EnsembleAnalysisParams.totalFramesPerUnit)
set(handles.visStimStart,'String',EnsembleAnalysisParams.visStimStartFrame)
set(handles.visStimEnd,'String',EnsembleAnalysisParams.visStimEndFrame)



EnsembleAnalysisParams.originalCodePath = uigetdir('','Define the code repository path first');
cd(EnsembleAnalysisParams.originalCodePath)
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
while EnsembleAnalysisParams.isSVDOutputLoaded == 0;
    [fileName filePath] = uigetfile('','Open the appropriate OUT.mat file');
    if ischar(fileName) == 1
        EnsembleAnalysisParams.isSaveDataLocationSet = 1;
        cd(filePath)
        load(fileName)
        EnsembleAnalysisParams.coreSVD = OUT.coreSVD;
        EnsembleAnalysisParams.isSVDOutputLoaded = 1;
        cd(EnsembleAnalysisParams.originalCodePath)
        save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
        set(handles.loadSVDoutput,'Enable','off')
        set(handles.loadSVDoutputStatus,'String','SVD OUT loaded','ForegroundColor','green','BackgroundColor','black')
        set(handles.EvsNEdFFseparator,'Enable','on')
    else
        EnsembleAnalysisParams.isSVDOutputLoaded = 1;
        set(handles.GUIstatusBox,'String','SVD Output loading interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
        save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
    end
end
EnsembleAnalysisParams.isSVDOutputLoaded = 0;
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')


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
    while EnsembleAnalysisParams.isEvsNEgroupingDone == 0
        set(handles.EvsNEseparationStatus,'String','Running','ForegroundColor','red','BackgroundColor','black')
        set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
        [grandDatabaseForEnsemblevsNonEnsemble] = SeparateAndGroupEvsNEdffData(EnsembleAnalysisParams);
        EnsembleAnalysisParams.isEvsNEgroupingDone = 1;
    end
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    save('GrandDatabaseForEnsemblevsNonEnsemble','grandDatabaseForEnsemblevsNonEnsemble')
    cd(EnsembleAnalysisParams.originalCodePath)
    EnsembleAnalysisParams.isEvsNEgroupingDone = 0;
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')

    set(handles.EvsNEdFFseparator,'Enable','off')
    set(handles.EvsNEseparationStatus,'String','Done','ForegroundColor','green','BackgroundColor','black')
    set(handles.AlphaDataExtractor,'Enable','on')
    cd(EnsembleAnalysisParams.originalCodePath)

catch
    set(handles.GUIstatusBox,'String','E vs NE data grouping interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.EvsNEseparationStatus,'String','Not yet done','ForegroundColor','red','BackgroundColor','black')
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
set(handles.loadSVDoutput,'Enable','off')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.loadSVDoutputStatus,'String','Not yet loaded','ForegroundColor','red')
set(handles.EvsNEseparationStatus,'String','Not yet done','ForegroundColor','red')
set(handles.alphaDataExtractionStatus,'String','Not yet done','ForegroundColor','red')
set(handles.ensembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.nonEnsembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
set(handles.saveAnalyzedDataLocationButton,'String','Specify save location for analyzed data','BackgroundColor',[0.94 0.94 0.94])
set(handles.loadReshapedEnsembleDffButton,'Enable','off','String','Load Reshaped Ensemble','ForegroundColor','black','BackgroundColor',[0.94 0.94 0.94])
set(handles.loadGrandAlphaDatabaseButton,'Enable','off','String','Load Grand Alpha database','ForegroundColor','black','BackgroundColor',[0.94 0.94 0.94])
set(handles.ensembleButton,'Enable','off','String','Do Ensemble','ForegroundColor','black','BackgroundColor',[0.94 0.94 0.94])
set(handles.nonEnsembleButton,'Enable','off','String','Do Non-Ensemble','ForegroundColor','black','BackgroundColor',[0.94 0.94 0.94])
set(handles.plotEnsembleButton,'String','Plot Ensemble','Enable','off','ForegroundColor','black','BackgroundColor',[0.94 0.94 0.94])
set(handles.plotNonEnsembleButton,'Enable','off','String','Plot Non-Ensemble','ForegroundColor','black','BackgroundColor',[0.94 0.94 0.94])
set(handles.loadReshapedN_EnsembleDffButton,'Enable','off','String','Load Reshaped N_E','ForegroundColor','black','BackgroundColor',[0.94 0.94 0.94])


% --- Executes on button press in resetLoadSVDout.
function resetLoadSVDout_Callback(hObject, eventdata, handles)
% hObject    handle to resetLoadSVDout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.loadSVDoutput,'Enable','on')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
set(handles.loadSVDoutputStatus,'String','Not yet loaded','ForegroundColor','red')
set(handles.EvsNEseparationStatus,'String','Not yet done','ForegroundColor','red')
set(handles.AlphaDataExtractor,'Enable','off')
set(handles.alphaDataExtractionStatus,'String','Not yet done','ForegroundColor','red')
set(handles.ensembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.nonEnsembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.ensembleButton,'Enable','off')
set(handles.nonEnsembleButton,'Enable','off')
set(handles.loadGrandAlphaDatabaseButton,'Enable','off')
set(handles.loadReshapedEnsembleDffButton,'Enable','off')
set(handles.loadReshapedN_EnsembleDffButton,'Enable','off')
set(handles.plotEnsembleButton,'Enable','off')
set(handles.plotNonEnsembleButton,'Enable','off')


% --- Executes on button press in resetGroupEvsNEdata.
function resetGroupEvsNEdata_Callback(hObject, eventdata, handles)
% hObject    handle to resetGroupEvsNEdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.loadSVDoutput,'Enable','off')
set(handles.EvsNEdFFseparator,'Enable','on')
set(handles.EvsNEseparationStatus,'String','Not yet done','ForegroundColor','red')
set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
set(handles.EvsNEseparationStatus,'String','Not yet done','ForegroundColor','red')
set(handles.AlphaDataExtractor,'Enable','off')
set(handles.alphaDataExtractionStatus,'String','Not yet done','ForegroundColor','red')
set(handles.ensembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.nonEnsembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.ensembleButton,'Enable','off')
set(handles.nonEnsembleButton,'Enable','off')
set(handles.loadGrandAlphaDatabaseButton,'Enable','off')
set(handles.loadReshapedEnsembleDffButton,'Enable','off')
set(handles.loadReshapedN_EnsembleDffButton,'Enable','off')
set(handles.plotEnsembleButton,'Enable','off')
set(handles.plotNonEnsembleButton,'Enable','off')



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
try
    load('ensembleAnalysisParams.mat')
    while EnsembleAnalysisParams.isAlphaDataExtracted == 0
        set(handles.alphaDataExtractionStatus,'String','Running','ForegroundColor','red','BackgroundColor','black')
        set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
        [grandAlphaDatabaseWithTrialNumbers] = ExtractAndSaveDffAlphaDataWithTrialNumsAndFrameNums(EnsembleAnalysisParams);
        EnsembleAnalysisParams.isAlphaDataExtracted = 1;
    end
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    EnsembleAnalysisParams.isAlphaDataExtracted = 0;
    save('GrandAlphaDatabaseWithTrialNumbers', 'grandAlphaDatabaseWithTrialNumbers')
    set(handles.AlphaDataExtractor,'Enable','off')
    set(handles.ensembleButton,'Enable','on')
    set(handles.nonEnsembleButton,'Enable','on')
    set(handles.alphaDataExtractionStatus,'String','Done','ForegroundColor','green','BackgroundColor','black')
    cd(EnsembleAnalysisParams.originalCodePath)
catch
    set(handles.GUIstatusBox,'String','Alpha data extraction interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.alphaDataExtractionStatus,'String','Not yet done','ForegroundColor','red','BackgroundColor','black')
end

% --- Executes on button press in resetAlphaDataExtraction.
function resetAlphaDataExtraction_Callback(hObject, eventdata, handles)
% hObject    handle to resetAlphaDataExtraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.loadSVDoutput,'Enable','off')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.AlphaDataExtractor,'Enable','on')
set(handles.alphaDataExtractionStatus,'String','Not yet done','ForegroundColor','red')
set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
set(handles.ensembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.nonEnsembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.ensembleButton,'Enable','off')
set(handles.nonEnsembleButton,'Enable','off')
set(handles.loadGrandAlphaDatabaseButton,'Enable','off')
set(handles.loadReshapedEnsembleDffButton,'Enable','off')
set(handles.loadReshapedN_EnsembleDffButton,'Enable','off')
set(handles.plotEnsembleButton,'Enable','off')
set(handles.plotNonEnsembleButton,'Enable','off')




% --- Executes on button press in ensembleButton.
function ensembleButton_Callback(hObject, eventdata, handles)
% hObject    handle to ensembleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
try 
    while EnsembleAnalysisParams.isEnsembleDone == 0
        cd(EnsembleAnalysisParams.saveAnalyzedData)
        load('GrandDatabaseForEnsemblevsNonEnsemble.mat')
        cd(EnsembleAnalysisParams.originalCodePath)
        [reshapedEnsembleDff] = alphaDependentDffForEnsemble(grandDatabaseForEnsemblevsNonEnsemble,EnsembleAnalysisParams);
        EnsembleAnalysisParams.isEnsembleDone = 1;
    end
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    save('ReshapedEnsembleDff', 'reshapedEnsembleDff')
    set(handles.ensembleButton,'Enable','off')
    set(handles.ensembleStatus,'String','Done','ForegroundColor','green','BackgroundColor','black')
    set(handles.loadGrandAlphaDatabaseButton,'Enable','on')
    set(handles.loadReshapedEnsembleDffButton,'Enable','on')
    cd(EnsembleAnalysisParams.originalCodePath)
catch
    set(handles.GUIstatusBox,'String','Ensemble grouping interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.ensembleStatus,'String','Not yet done','ForegroundColor','red','BackgroundColor','black')
end


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
set(handles.loadGrandAlphaDatabaseButton,'String','Load Grand Alpha Database','BackgroundColor',[0.94 0.94 0.94])
set(handles.loadReshapedEnsembleDffButton,'String','Load Reshaped Ensemble','BackgroundColor',[0.94 0.94 0.94])
set(handles.plotEnsembleButton,'BackgroundColor',[0.94 0.94 0.94])

set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
set(handles.nonEnsembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.loadReshapedN_EnsembleDffButton,'Enable','off')
set(handles.plotEnsembleButton,'Enable','off')
set(handles.plotNonEnsembleButton,'Enable','off')



% --- Executes on button press in plotEnsembleButton.
function plotEnsembleButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotEnsembleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
try
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    load('GrandAlphaDatabaseWithTrialNumbers.mat')
    load('ReshapedEnsembleDff.mat')
    [grandAlphaDependentCellDff_E,fEnsemble] = PlotAlphaDependentMeanResponse(reshapedEnsembleDff,grandAlphaDatabaseWithTrialNumbers,EnsembleAnalysisParams);
    title('Alpha depenent cell and trial averaged Ensemble dF/F')
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    save('GrandAlphaDependent_E_CellDff', 'grandAlphaDependentCellDff_E')
    saveas(fEnsemble,'AlphaDependentCellAndTrialAveragedEnsembleResponse.fig')
    cd(EnsembleAnalysisParams.originalCodePath)
    set(handles.plotEnsembleButton,'BackgroundColor','green')
catch
    set(handles.GUIstatusBox,'String','Plot ensemble error','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.plotEnsembleButton,'BackgroundColor',[0.94 0.94 0.94])
end



% --- Executes on button press in loadGrandAlphaDatabaseButton.
function loadGrandAlphaDatabaseButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadGrandAlphaDatabaseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
try
    while EnsembleAnalysisParams.isGrandAlphaDatabaseLoaded == 0
        cd(EnsembleAnalysisParams.saveAnalyzedData)
        load('GrandAlphaDatabaseWithTrialNumbers.mat')
        set(handles.loadGrandAlphaDatabaseButton,'String','Alpha Database Loaded','BackgroundColor','green')
        set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
        EnsembleAnalysisParams.isGrandAlphaDatabaseLoaded = 1;
    end
catch
    set(handles.GUIstatusBox,'String','Grand alpha database loading interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.loadGrandAlphaDatabaseButton,'String','Load Grand Alpha Database')
end

% --- Executes on button press in loadReshapedEnsembleDffButton.
function loadReshapedEnsembleDffButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadReshapedEnsembleDffButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
try
    while EnsembleAnalysisParams.isReshapedEnsembleDffLoaded == 0
          cd(EnsembleAnalysisParams.saveAnalyzedData)
          load('ReshapedEnsembleDff.mat')
          set(handles.loadReshapedEnsembleDffButton,'String','Reshaped Ensemble Loaded','BackgroundColor','green')
          set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
          set(handles.plotEnsembleButton,'Enable','on')
          set(handles.plotEnsembleButton,'BackgroundColor','red')
          EnsembleAnalysisParams.isReshapedEnsembleDffLoaded = 1;
    end
catch
    set(handles.GUIstatusBox,'String','Reshaped ensemble loading interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.loadReshapedEnsembleDffButton,'String','Load Reshaped Ensemble dF/F')
end



% --- Executes on button press in saveAnalyzedDataLocationButton.
function saveAnalyzedDataLocationButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveAnalyzedDataLocationButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
while EnsembleAnalysisParams.isSaveDataLocationSet == 0
    EnsembleAnalysisParams.saveAnalyzedData = uigetdir('','Specify the location to save all analyzed data');
    if ischar(EnsembleAnalysisParams.saveAnalyzedData) == 1
        EnsembleAnalysisParams.isSaveDataLocationSet = 1;
        cd(EnsembleAnalysisParams.saveAnalyzedData)
        mkdir('AnalyzedEnsembleVsNonEnsembleData')
        cd(strcat(EnsembleAnalysisParams.saveAnalyzedData,'\AnalyzedEnsembleVsNonEnsembleData'))
        analysisParams.frameRate = EnsembleAnalysisParams.frameRate;
        analysisParams.framePerTrial = EnsembleAnalysisParams.totalFramesPerUnit;
        analysisParams.visStimStartFrameNum = EnsembleAnalysisParams.visStimStartFrame;
        analysisParams.visStimEndFrameNum = EnsembleAnalysisParams.visStimEndFrame;
        analysisParams.whichEnsembleAnalyzed = EnsembleAnalysisParams.whichEnsemble;
        save('AnalysisParams','analysisParams')

        EnsembleAnalysisParams.saveAnalyzedData = strcat(EnsembleAnalysisParams.saveAnalyzedData,'\AnalyzedEnsembleVsNonEnsembleData');
        cd(EnsembleAnalysisParams.originalCodePath)
        save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
        set(handles.saveAnalyzedDataLocationButton,'String','Save location specified','BackgroundColor','green')
        set(handles.loadSVDoutput,'Enable','on')
    else
        EnsembleAnalysisParams.isSaveDataLocationSet = 1;
        save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
        set(handles.GUIstatusBox,'String','Analyzed data save location not specified','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    end
end
cd(EnsembleAnalysisParams.originalCodePath)
EnsembleAnalysisParams.isSaveDataLocationSet = 0;
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')


% --- Executes on button press in nonEnsembleButton.
function nonEnsembleButton_Callback(hObject, eventdata, handles)
% hObject    handle to nonEnsembleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
try
    while EnsembleAnalysisParams.isNonEnsembleDone == 0
        cd(EnsembleAnalysisParams.saveAnalyzedData)
        load('GrandDatabaseForEnsemblevsNonEnsemble.mat')
        cd(EnsembleAnalysisParams.originalCodePath)
        [reshapedNonEnsembleDff] = alphaDependentDffForNonEnsemble(grandDatabaseForEnsemblevsNonEnsemble,EnsembleAnalysisParams);
        EnsembleAnalysisParams.isNonEnsembleDone = 1;
    end
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    save('ReshapedNonEnsembleDff', 'reshapedNonEnsembleDff')
    set(handles.nonEnsembleButton,'Enable','off')
    set(handles.nonEnsembleStatus,'String','Done','ForegroundColor','green','BackgroundColor','black')
    set(handles.loadReshapedN_EnsembleDffButton,'Enable','on')
    
    cd(EnsembleAnalysisParams.originalCodePath)
catch
    set(handles.GUIstatusBox,'String','Non-Ensemble grouping interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.nonEnsembleStatus,'String','Not yet done','ForegroundColor','red','BackgroundColor','black')
end


% --- Executes on button press in resetNonEnsemble.
function resetNonEnsemble_Callback(hObject, eventdata, handles)
% hObject    handle to resetNonEnsemble (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.loadSVDoutput,'Enable','off')
set(handles.EvsNEdFFseparator,'Enable','off')
set(handles.AlphaDataExtractor,'Enable','off')
set(handles.ensembleButton,'Enable','off')
set(handles.nonEnsembleButton,'Enable','on')
set(handles.loadReshapedN_EnsembleDffButton,'Enable','off','BackgroundColor',[0.94 0.94 0.94])
set(handles.plotNonEnsembleButton,'Enable','off','BackgroundColor',[0.94 0.94 0.94])
set(handles.nonEnsembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.loadReshapedN_EnsembleDffButton,'String','Load Reshaped Ensemble','BackgroundColor',[0.94 0.94 0.94])
set(handles.plotNonEnsembleButton,'BackgroundColor',[0.94 0.94 0.94])

set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
set(handles.nonEnsembleStatus,'String','Not yet done','ForegroundColor','red')
set(handles.nonEnsembleButton,'Enable','on')
set(handles.loadReshapedN_EnsembleDffButton,'Enable','off')
set(handles.plotNonEnsembleButton,'Enable','off')


% --- Executes on button press in plotNonEnsembleButton.
function plotNonEnsembleButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotNonEnsembleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
try
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    load('GrandAlphaDatabaseWithTrialNumbers.mat')
    load('ReshapedNonEnsembleDff.mat')
    [grandAlphaDependentCellDff_NE,fN_Ensemble] = PlotAlphaDependentMeanResponse(reshapedNonEnsembleDff,grandAlphaDatabaseWithTrialNumbers,EnsembleAnalysisParams);
    title('Alpha depenent cell and trial averaged Non-Ensemble dF/F')
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    save('GrandAlphaDependent_NE_CellDff', 'grandAlphaDependentCellDff_NE')
    saveas(fN_Ensemble,'AlphaDependentCellAndTrialAveragedNonEnsembleResponse.fig')
    cd(EnsembleAnalysisParams.originalCodePath)
    set(handles.plotNonEnsembleButton,'BackgroundColor','green')
catch
    set(handles.GUIstatusBox,'String','Plot non-ensemble error','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.plotNonEnsembleButton,'BackgroundColor',[0.94 0.94 0.94])
end


% --- Executes on button press in loadReshapedN_EnsembleDffButton.
function loadReshapedN_EnsembleDffButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadReshapedN_EnsembleDffButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('ensembleAnalysisParams.mat')
try
    while EnsembleAnalysisParams.isReshapedNonEnsembleDffLoaded == 0
        cd(EnsembleAnalysisParams.saveAnalyzedData)
        load('ReshapedNonEnsembleDff.mat')
        set(handles.loadReshapedN_EnsembleDffButton,'String','Reshaped N_Ensemble Loaded','BackgroundColor','green')
        set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
        set(handles.plotNonEnsembleButton,'Enable','on')
        set(handles.plotNonEnsembleButton,'BackgroundColor','red')
        EnsembleAnalysisParams.isReshapedNonEnsembleDffLoaded = 1;
    end
catch
    set(handles.GUIstatusBox,'String','Reshaped non-ensemble loading interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.loadReshapedN_EnsembleDffButton,'String','Load Reshaped N_Ensemble')
end



function visStimStart_Callback(hObject, eventdata, handles)
% hObject    handle to visStimStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of visStimStart as text
%        str2double(get(hObject,'String')) returns contents of visStimStart as a double
load('ensembleAnalysisParams.mat')
EnsembleAnalysisParams.EnsembleAnalysisParams.visStimStartFrame = str2double(get(hObject,'String'));
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')


% --- Executes during object creation, after setting all properties.
function visStimStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to visStimStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function visStimEnd_Callback(hObject, eventdata, handles)
% hObject    handle to visStimEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of visStimEnd as text
%        str2double(get(hObject,'String')) returns contents of visStimEnd as a double
load('ensembleAnalysisParams.mat')
EnsembleAnalysisParams.EnsembleAnalysisParams.visStimEndFrame = str2double(get(hObject,'String'));
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')


% --- Executes during object creation, after setting all properties.
function visStimEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to visStimEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
