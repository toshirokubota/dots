function varargout = groupThem(varargin)
% GROUPTHEM MATLAB code for groupThem.fig
%      GROUPTHEM, by itself, creates a new GROUPTHEM or raises the existing
%      singleton*.
%
%      H = GROUPTHEM returns the handle to a new GROUPTHEM or the handle to
%      the existing singleton*.
%
%      GROUPTHEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GROUPTHEM.M with the given input arguments.
%
%      GROUPTHEM('Property','Value',...) creates a new GROUPTHEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before groupThem_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to groupThem_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help groupThem

% Last Modified by GUIDE v2.5 15-Oct-2013 08:16:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @groupThem_OpeningFcn, ...
                   'gui_OutputFcn',  @groupThem_OutputFcn, ...
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


% --- Executes just before groupThem is made visible.
function groupThem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to groupThem (see VARARGIN)

% Choose default command line output for groupThem
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes groupThem wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = groupThem_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('mouse pressed.\n');


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('mouse moved.\n');
