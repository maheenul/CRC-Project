function varargout = GUI_CRC(varargin)
% GUI_CRC MATLAB code for GUI_CRC.fig
%      GUI_CRC, by itself, creates a new GUI_CRC or raises the existing
%      singleton*.
%
%      H = GUI_CRC returns the handle to a new GUI_CRC or the handle to
%      the existing singleton*.
%
%      GUI_CRC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CRC.M with the given input arguments.
%
%      GUI_CRC('Property','Value',...) creates a new GUI_CRC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_CRC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_CRC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_CRC

% Last Modified by GUIDE v2.5 02-May-2018 14:37:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_CRC_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_CRC_OutputFcn, ...
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


% --- Executes just before GUI_CRC is made visible.
function GUI_CRC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_CRC (see VARARGIN)

% Choose default command line output for GUI_CRC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_CRC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_CRC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function inputInfo_Callback(hObject, eventdata, handles)
% hObject    handle to inputInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputInfo as text
%        str2double(get(hObject,'String')) returns contents of inputInfo as a double


% --- Executes during object creation, after setting all properties.
function inputInfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputEncoded_Callback(hObject, eventdata, handles)
% hObject    handle to inputEncoded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputEncoded as text
%        str2double(get(hObject,'String')) returns contents of inputEncoded as a double


% --- Executes during object creation, after setting all properties.
function inputEncoded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputEncoded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PBEncode.
function PBEncode_Callback(hObject, eventdata, handles)
% hObject    handle to PBEncode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
genPoly = [1 1 0 0 0 1 1 0 0 1 1];
infoBits = str2num(get(handles.inputInfo,'String'));
encodedBits = CRCGenerator(genPoly,infoBits);
set(handles.resultEncoded,'string',num2str(encodedBits));
set(handles.inputEncoded,'String',num2str(encodedBits));



% --- Executes on button press in PBVerify.
function PBVerify_Callback(hObject, eventdata, handles)
% hObject    handle to PBVerify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
genPoly = [1 1 0 0 0 1 1 0 0 1 1];
encodedBits = str2num(get(handles.inputEncoded,'String'));
CRCValid = CRCVerifier(genPoly,encodedBits);
if (CRCValid)
    display="The encoded bits are valid";
else
    display="The encoded bits are invalid";
end
set(handles.resultVerify,'string',display);


% --- Executes during object creation, after setting all properties.
function resultVerify_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resultVerify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function resultEncoded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resultEncoded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
