function varargout = responsi(varargin)
% RESPONSI MATLAB code for responsi.fig
%      RESPONSI, by itself, creates a new RESPONSI or raises the existing
%      singleton*.
%
%      H = RESPONSI returns the handle to a new RESPONSI or the handle to
%      the existing singleton*.
%
%      RESPONSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI.M with the given input arguments.
%
%      RESPONSI('Property','Value',...) creates a new RESPONSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before responsi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to responsi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help responsi

% Last Modified by GUIDE v2.5 25-Jun-2021 16:21:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @responsi_OpeningFcn, ...
                   'gui_OutputFcn',  @responsi_OutputFcn, ...
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


% --- Executes just before responsi is made visible.
function responsi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to responsi (see VARARGIN)

% Choose default command line output for responsi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes responsi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = responsi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%menampilkan data
opts = detectImportOptions('datarmh.xlsx');
opts.SelectedVariableNames = (1);
data1 = readmatrix('datarmh.xlsx',opts);

opts = detectImportOptions('datarmh.xlsx');
opts.SelectedVariableNames = (3:8);
data2 = readmatrix('datarmh.xlsx',opts);
%data dimaksukan ke tabel 1
data = [data1 data2];
set(handles.tabelrmh,'data',data);
opts = detectImportOptions('datarmh.xlsx');
opts.SelectedVariableNames = (3:8);

x = readmatrix('datarmh.xlsx',opts);
k=[0,1,1,1,1,1];%nilai atribut, 0(cost) dan 1(benefit)
w=[0.30,0.20,0.23,0.10,0.07,0.10];%bobot

[m,n]=size (x); 
R=zeros (m,n);
for j=1:n
    if k(j)==1
        %menghitung normalisasi kriteria jenis keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        %menghitung normalisasi kriteria jenis biaya
        R(:,j)=min(x(:,j))./x(:,j);
    end
end
%perhitungan hasil perankingan
for i=1:m
 V(i)= sum(w.*R(i,:));
end
%menampilkan hasil perhitungan rumah
Vtranspose=V.'; 
Vtranspose=num2cell(Vtranspose);
opts = detectImportOptions('datarmh.xlsx');
opts.SelectedVariableNames = (2);
x2= readtable('datarmh.xlsx',opts);
x2 = table2cell(x2);
x2=[x2 Vtranspose];
x2=sortrows(x2,-2);
x2 = x2(1:20,1);
%data perhitungan dimasukan ke tabel 2
set(handles.uitable2, 'data', x2);
