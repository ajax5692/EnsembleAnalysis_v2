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

% Last Modified by GUIDE v2.5 16-Oct-2023 17:18:58

% Begin initialization code - DO NOT EDIT
p = mfilename('fullpath');
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

set(handles.performAnalysisButton,'Enable','off')

load('ensembleAnalysisParams.mat')
EnsembleAnalysisParams.originalCodePath = pwd;
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
EnsembleAnalysisParams.layerDataPath(:) = [];
set(handles.numLayersUserInput,'String',EnsembleAnalysisParams.numLayers)
set(handles.frameRate,'String',EnsembleAnalysisParams.frameRate)
set(handles.whichEnsemble,'String',EnsembleAnalysisParams.whichEnsemble)
set(handles.totalFramesPerUnit,'String',EnsembleAnalysisParams.totalFramesPerUnit)
set(handles.visStimStart,'String',EnsembleAnalysisParams.visStimStartFrame)
set(handles.visStimEnd,'String',EnsembleAnalysisParams.visStimEndFrame)



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
        analysisParams.dateTimeStamp = datetime('now');
        save('AnalysisParams','analysisParams')

        EnsembleAnalysisParams.saveAnalyzedData = strcat(EnsembleAnalysisParams.saveAnalyzedData,'\AnalyzedEnsembleVsNonEnsembleData');
        cd(EnsembleAnalysisParams.originalCodePath)
        save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
        set(handles.saveAnalyzedDataLocationButton,'String','Save location specified','BackgroundColor','green')
        set(handles.performAnalysisButton,'Enable','on','String','Perform analysis','ForegroundColor','black','FontWeight','bold')
    else
        EnsembleAnalysisParams.isSaveDataLocationSet = 1;
        save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
        set(handles.GUIstatusBox,'String','Analyzed data save location not specified','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    end
end
cd(EnsembleAnalysisParams.originalCodePath)
EnsembleAnalysisParams.isSaveDataLocationSet = 0;
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')


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


% --- Executes on button press in performAnalysisButton.
function performAnalysisButton_Callback(hObject, eventdata, handles)
% hObject    handle to performAnalysisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This part loads the OUT.mat file
load('ensembleAnalysisParams.mat')
functionRunningIndicator = uifigure;
functionRunningIndicator.Position(3:4) = [400 100];
textInFunctionRunningIndicator = uiprogressdlg(functionRunningIndicator,'Title','Main Analysis Running','Indeterminate','on');
w = multiWaitbar('Overall Progress',0.125);
set(handles.performAnalysisButton,'String','Analysis running','ForegroundColor','red')
while EnsembleAnalysisParams.isSVDOutputLoaded == 0;
    [fileName filePath] = uigetfile('','Load the appropriate OUT.mat file');
    if ischar(fileName) == 1
        EnsembleAnalysisParams.isSaveDataLocationSet = 1;
        cd(filePath)
        load(fileName)
        EnsembleAnalysisParams.coreSVD = OUT.coreSVD;
        EnsembleAnalysisParams.isSVDOutputLoaded = 1;
        cd(EnsembleAnalysisParams.originalCodePath)
        save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')        
    else
        EnsembleAnalysisParams.isSVDOutputLoaded = 1;
        set(handles.GUIstatusBox,'String','SVD Output loading interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
        save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
        set(handles.performAnalysisButton,'String','Analysis interrupted','ForegroundColor','black','FontWeight','bold')
    end
end
EnsembleAnalysisParams.isSVDOutputLoaded = 0;
save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')

%This part Separates the ensemble and non-ensemble data
w = multiWaitbar('Overall Progress',0.25);
try
    load('ensembleAnalysisParams.mat')
    while EnsembleAnalysisParams.isEvsNEgroupingDone == 0
        set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
        [grandDatabaseForEnsemblevsNonEnsemble,EnsembleAnalysisParams] = SeparateAndGroupEvsNEdffData(EnsembleAnalysisParams);
        EnsembleAnalysisParams.isEvsNEgroupingDone = 1;
    end
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    save('GrandDatabaseForEnsemblevsNonEnsemble','grandDatabaseForEnsemblevsNonEnsemble')
    cd(EnsembleAnalysisParams.originalCodePath)
    EnsembleAnalysisParams.isEvsNEgroupingDone = 0;
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')

    cd(EnsembleAnalysisParams.originalCodePath)

catch
    set(handles.GUIstatusBox,'String','E vs NE data grouping interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.performAnalysisButton,'String','Analysis interrupted','ForegroundColor','black','FontWeight','bold')
    cd(EnsembleAnalysisParams.originalCodePath)
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
end


%This part extracts the alpha data and the corresponding trial numbers from
%the appropriate session struct file
w = multiWaitbar('Overall Progress',0.375);
try
    load('ensembleAnalysisParams.mat')
    while EnsembleAnalysisParams.isAlphaDataExtracted == 0
        set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
        [grandAlphaDatabaseWithTrialNumbers] = ExtractAndSaveDffAlphaDataWithTrialNumsAndFrameNums(EnsembleAnalysisParams);
        EnsembleAnalysisParams.isAlphaDataExtracted = 1;
    end
    cd(EnsembleAnalysisParams.saveAnalyzedData)
    EnsembleAnalysisParams.isAlphaDataExtracted = 0;
    save('GrandAlphaDatabaseWithTrialNumbers', 'grandAlphaDatabaseWithTrialNumbers')
    cd(EnsembleAnalysisParams.originalCodePath)
catch
    set(handles.GUIstatusBox,'String','Alpha data extraction interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.performAnalysisButton,'String','Analysis interrupted','ForegroundColor','black','FontWeight','bold')
    cd(EnsembleAnalysisParams.originalCodePath)
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
end


%This part evaluates the alpha dependent dF/F for the ensemble cells and
%reshapes it into a 3D matrix with dimensions like this:
%cells*totalTrials*frames
w = multiWaitbar('Overall Progress',0.5);
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
    cd(EnsembleAnalysisParams.originalCodePath)
catch
    set(handles.GUIstatusBox,'String','Ensemble grouping interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.performAnalysisButton,'String','Analysis interrupted','ForegroundColor','black','FontWeight','bold')
    cd(EnsembleAnalysisParams.originalCodePath)
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
end


%This part evaluates the alpha dependent dF/F for the non-ensemble cells
%and reshapes it into a 3D matrix with dimensions like this:
%cells*totalTrials*frames
w = multiWaitbar('Overall Progress',0.625);
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
    cd(EnsembleAnalysisParams.originalCodePath)
catch
    set(handles.GUIstatusBox,'String','Non-Ensemble grouping interrupted','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.performAnalysisButton,'String','Analysis interrupted','ForegroundColor','black','FontWeight','bold')
    cd(EnsembleAnalysisParams.originalCodePath)
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
end


%This part plots the ensemble dF/F
w = multiWaitbar('Overall Progress',0.75);
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
catch
    set(handles.GUIstatusBox,'String','Plot ensemble error','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.performAnalysisButton,'String','Analysis interrupted','ForegroundColor','black','FontWeight','bold')
    cd(EnsembleAnalysisParams.originalCodePath)
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
end


%This part plots the non-ensemble dF/F
w = multiWaitbar('Overall Progress',0.875);
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
    set(handles.performAnalysisButton,'String','Analysis complete','ForegroundColor','black','FontWeight','bold','Backgroundcolor','green')
catch
    set(handles.GUIstatusBox,'String','Plot non-ensemble error','ForegroundColor',[0.64 0.08 0.18],'FontWeight','bold')
    set(handles.performAnalysisButton,'String','Analysis interrupted','ForegroundColor','black','FontWeight','bold')
    cd(EnsembleAnalysisParams.originalCodePath)
    save('ensembleAnalysisParams.mat','EnsembleAnalysisParams')
end
w = multiWaitbar('Overall Progress',1);
w = multiWaitbar('Overall Progress','Reset','Close');
close(functionRunningIndicator)
close(textInFunctionRunningIndicator)
clear textInFunctionRunningIndicator functionRunningIndicator

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


% --- Executes on button press in resetGUI.
function resetGUI_Callback(hObject, eventdata, handles)
% hObject    handle to resetGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.performAnalysisButton,'Enable','off','String','Perform Analysis','BackgroundColor',[0.94 0.94 0.94])
set(handles.GUIstatusBox,'String','No issues','ForegroundColor','black','FontWeight','bold')
set(handles.saveAnalyzedDataLocationButton,'String','Specify save location for analyzed data','FontWeight','bold','ForegroundColor','black','BackgroundColor',[0.94 0.94 0.94])
w = multiWaitbar('Overall Progress','Reset','Close');
w = multiWaitbar('Calculating dF/F','Reset','Close');
