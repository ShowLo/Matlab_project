function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 24-Jul-2016 21:02:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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



% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%简谱输入
function notation_Callback(hObject, eventdata, handles)
% hObject    handle to notation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(hObject,'String');
%检查输入是否为空
if isempty(a)
    set(hObject,'String',0);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of notation as text
%        str2double(get(hObject,'String')) returns contents of notation as a double


% --- Executes during object creation, after setting all properties.
function notation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to notation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%节拍数输入
function beatNum_Callback(hObject, eventdata, handles)
% hObject    handle to beatNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(hObject,'String');
%检查输入是否为空
if isempty(a)
    set(hObject,'String',0);
end
%以空格分隔字符串
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of beatNum as text
%        str2double(get(hObject,'String')) returns contents of beatNum as a double


% --- Executes during object creation, after setting all properties.
function beatNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beatNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%保存图像按钮
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fileName,path] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'},'保存图像');
if fileName == 0
    %若用户取消保存，直接返回
    return
else
    filePath = strcat(path,fileName);                  %文件保存路径
    photo = getframe(handles.imgShowAxes);   %从坐标轴中获取图像
    imwrite(photo.cdata,filePath);                      %保存图像
end


%曲调
% --- Executes on selection change in tune.
function tune_Callback(hObject, eventdata, handles)
% hObject    handle to tune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns tune contents as cell array
%        contents{get(hObject,'Value')} returns selected item from tune


% --- Executes during object creation, after setting all properties.
function tune_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%乐器名
% --- Executes on selection change in instrument.
function instrument_Callback(hObject, eventdata, handles)
% hObject    handle to instrument (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns instrument contents as cell array
%        contents{get(hObject,'Value')} returns selected item from instrument


% --- Executes during object creation, after setting all properties.
function instrument_CreateFcn(hObject, eventdata, handles)
% hObject    handle to instrument (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%升降调
% --- Executes on selection change in rise_fall_tune.
function rise_fall_tune_Callback(hObject, eventdata, handles)
% hObject    handle to rise_fall_tune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rise_fall_tune contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rise_fall_tune


% --- Executes during object creation, after setting all properties.
function rise_fall_tune_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rise_fall_tune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%播放按钮
% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%获取合成音乐并播放
musicGUI = getMusic(handles);
sound(musicGUI);
guidata(hObject,handles);

% --- Executes on button press in display.
function display_Callback(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%获取单选按钮组的选择
if get(handles.wave,'value')
    option = 1;                                     %选择一，显示音乐波形
elseif get(handles.spectrum,'value')
    option = 2;                                     %选择二，显示音乐频谱
end

%获取音乐
[musicGUI,last_time,Fs] = getMusic(handles);
total_time = sum(last_time);              %音乐总时长
timeLen = length(musicGUI);             %时域采样点总数
%时域信号
t = linspace(0,total_time - 1 / Fs,timeLen);
switch option
    case 1
        cla;
        plot(t,musicGUI);                       %画出音乐波形
    case 2
        %做快速傅里叶变换，返回频域信号和频谱，然后画出来
        [f,fftdata] = drawSpectrum(musicGUI,Fs);
        cla;
        plot(f,fftdata);
end
guidata(hObject,handles);



%播放速度
% --- Executes on selection change in playSpeed.
function playSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to playSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns playSpeed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from playSpeed


% --- Executes during object creation, after setting all properties.
function playSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to playSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%采样频率
function sampleFreq_Callback(hObject, eventdata, handles)
% hObject    handle to sampleFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
a = str2num(get(hObject,'String'));
%检查输入是否为空
if isempty(a)
    set(hObject,'String',0);
end
%以空格分隔字符串
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of sampleFreq as text
%        str2double(get(hObject,'String')) returns contents of sampleFreq as a double


% --- Executes during object creation, after setting all properties.
function sampleFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampleFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
