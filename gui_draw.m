function varargout = gui_draw(varargin)
% GUI_DRAW MATLAB code for gui_draw.fig
%      GUI_DRAW, by itself, creates a new GUI_DRAW or raises the existing
%      singleton*.
%
%      H = GUI_DRAW returns the handle to a new GUI_DRAW or the handle to
%      the existing singleton*.
%
%      GUI_DRAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DRAW.M with the given input arguments.
%
%      GUI_DRAW('Property','Value',...) creates a new GUI_DRAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_draw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_draw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_draw

% Last Modified by GUIDE v2.5 21-Sep-2019 20:02:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_draw_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_draw_OutputFcn, ...
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


% --- Executes just before gui_draw is made visible.
function gui_draw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_draw (see VARARGIN)

% Choose default command line output for gui_draw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Drawing
set_up_the_drawing(handles);

% UIWAIT makes gui_draw wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_draw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_draw_reset.
function button_draw_reset_Callback(hObject, eventdata, handles)
% hObject    handle to button_draw_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xy;

cla(handles.draw_axes);
xy = [];
set_up_the_drawing(handles);

% --- Executes on button press in button_draw_ok.
function button_draw_ok_Callback(hObject, eventdata, handles)
% hObject    handle to button_draw_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xy;
if ~isempty(xy)
    n = str2num(get(handles.text_nocircles,'String'));
    fourier_epicycles(xy(:,1), xy(:,2), n);
end

% --- Executes on button press in button_minus.
function button_minus_Callback(hObject, eventdata, handles)
% hObject    handle to button_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = str2num(get(handles.text_nocircles,'String'))-1;
if value > 1
    set(handles.text_nocircles,'String', num2str(value));
end

% --- Executes on button press in button_add.
function button_add_Callback(hObject, eventdata, handles)
% hObject    handle to button_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global xy;

value = str2num(get(handles.text_nocircles,'String'))+1;
if value <= size(xy,1)
    set(handles.text_nocircles,'String', num2str(value));
end

% --- Sets up the drawing space
function set_up_the_drawing(handles)
% Coordinates of the future drawing
global xy;
xy = [];

try
% Drawing functionality
title(handles.draw_axes,'Please draw your custom line');
hFH = imfreehand();
if isempty(hFH)
  % Bail out
  return;
end
xy = hFH.getPosition;
xy = [xy; xy(1,:)];
delete(hFH);
xCoordinates = xy(:, 1);
yCoordinates = xy(:, 2);
plot(xCoordinates, yCoordinates, 'r', 'LineWidth', 2);
hold off;

% Set the default number of circles
set(handles.text_nocircles,'String', size(xy,1));
catch me
end