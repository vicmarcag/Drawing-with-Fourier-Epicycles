function varargout = fourier_main(varargin)
% FOURIER_MAIN MATLAB code for fourier_main.fig
%      FOURIER_MAIN, by itself, creates a new FOURIER_MAIN or raises the existing
%      singleton*.
%
%      H = FOURIER_MAIN returns the handle to a new FOURIER_MAIN or the handle to
%      the existing singleton*.
%
%      FOURIER_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIER_MAIN.M with the given input arguments.
%
%      FOURIER_MAIN('Property','Value',...) creates a new FOURIER_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fourier_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fourier_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fourier_main

% Last Modified by GUIDE v2.5 21-Sep-2019 12:15:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fourier_main_OpeningFcn, ...
                   'gui_OutputFcn',  @fourier_main_OutputFcn, ...
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


% --- Executes just before fourier_main is made visible.
function fourier_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fourier_main (see VARARGIN)

% Choose default command line output for fourier_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fourier_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fourier_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_draw.
function button_draw_Callback(hObject, eventdata, handles)
% hObject    handle to button_draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_draw;

% --- Executes on button press in button_coordinates.
function button_coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to button_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, filepath] = uigetfile({'*.mat','MATLAB Files'},...
  'Select coordinates data file');

if ~isempty(filename)
    data = load([filepath, filename]);
    if ~isfield(data, 'X')
        errordlg('The selected file does not contain an X vector of coordinates.');
    elseif ~isfield(data, 'Y')
        errordlg('The selected file does not contain a Y vector of coordinates.');
    else
        if length(data.X) ~= length(data.Y)
            errordlg('The lengths of X and Y are not the same!.');
        else
            fourier_epicycles(data.X, data.Y);
        end
    end
end
 
