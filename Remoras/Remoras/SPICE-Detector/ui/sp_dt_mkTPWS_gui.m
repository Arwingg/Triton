function sp_dt_mkTPWS_gui

global REMORA
% button grid layouts
% 14 rows, 4 columns
% button grid layouts
% 14 rows, 4 columns
r = 10; % rows      (extra space for separations btw sections)
c = 2;  % columns
h = 1/r;
w = 1/c;
dy = h * 0.8;
% dx = 0.008;
% ybuff = h*.2;
% y position (relative units)
y = 1:-h:0;

% x position (relative units)
x = [.05,.5];


% colors
bgColor = [1 1 1];  % white
bgColor3 = [.75 .875 1]; % light green 


% Setup variables:
defaultPos = [0.35,0.4,0.25,0.25];
% open and setup figure window

% If window already exists, close
if isfield(REMORA.fig, 'sp_dt_mkTPWS')
    if isgraphics(REMORA.fig.sp_dt_mkTPWS)
        close(REMORA.fig.sp_dt_mkTPWS)
    end
end

if ~isfield(REMORA.spice_dt,'mkTPWS')
    REMORA.spice_dt.mkTPWS = [];
end

REMORA.fig.sp_dt_mkTPWS = figure( ...
    'NumberTitle','off', ...
    'Name','Make TPWS from detections',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on');

REMORA.spice_dt_mkTPWS = [];
labelStr = 'Specify Detection Information';
btnPos=[0 y(2) w*c h];
REMORA.spice_dt_mkTPWS.headtext = uicontrol(REMORA.fig.sp_dt_mkTPWS, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'String',labelStr, ...
    'FontUnits','points', ...
    'FontWeight','bold',...
    'FontSize',11,...
    'Visible','on'); 


labelStr = 'Base Folder';
btnPos=[x(1) y(3) .5*w dy];
REMORA.spice_dt_mkTPWS.baseDirTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Base Folder Editable Text
if ~isfield(REMORA.spice_dt.mkTPWS, 'baseDir')
    REMORA.spice_dt.mkTPWS.baseDir = '';
end
btnPos=[0+w/2 y(3) (w*c)*.7 dy];
REMORA.spice_dt_mkTPWS.baseDirEdTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',REMORA.spice_dt.mkTPWS.baseDir,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','sp_dt_TPWS_control(''setTPWSBaseDir'')');

% Base Folder Checkbox
labelStr = 'Run on Subfolders';
btnPos=[0+w/2 y(4) (w*c)*.7 dy];
if ~isfield(REMORA.spice_dt.mkTPWS,'subDirTF')
    REMORA.spice_dt.mkTPWS.subDirTF = 1;
end
REMORA.spice_dt_mkTPWS.subDirCheckBox = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
    'Style','checkbox',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',labelStr,...
    'Value',REMORA.spice_dt.mkTPWS.subDirTF,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','sp_dt_TPWS_control(''setSubDirTF'')');

% Output Folder Text
labelStr = 'Output Folder';
btnPos=[x(1) y(5) w/2 dy];
REMORA.spice_dt_mkTPWS.outDirTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
   'Style','text',...
   'Units','normalized',...
   'HorizontalAlignment','left',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Output Folder Editable Text
if ~isfield(REMORA.spice_dt.mkTPWS, 'outDir')
    REMORA.spice_dt.mkTPWS.outDir = '';
end
btnPos=[0+w/2 y(5) (w*c)*.7 dy];
REMORA.spice_dt_mkTPWS.outDirEdTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',REMORA.spice_dt.mkTPWS.outDir,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_TPWS_control(''setTPWSOutDir'')');

% Filter String Text
labelStr = 'Partial String to Match (optional)';
btnPos=[x(1) y(6) w dy];
REMORA.spice_dt_mkTPWS.filterStringTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

%  Filter String Editable Text
if ~isfield(REMORA.spice_dt.mkTPWS, 'filterString')
    REMORA.spice_dt.mkTPWS.filterString = '';
end
btnPos=[x(2) y(6) w*.9 dy];
REMORA.spice_dt_mkTPWS.filterStringEdTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',REMORA.spice_dt.mkTPWS.filterString,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_TPWS_control(''setTPWSFilterString'')');

%% Species name TPWS
labelStr = 'Species name for TPWS file name';
btnPos=[x(1) y(7) w*1.5 dy];
REMORA.spice_dt_mkTPWS.spNameTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

%  Species name Editable Text
if ~isfield(REMORA.spice_dt.mkTPWS, 'spName')
    REMORA.spice_dt.mkTPWS.spName = 'Delphin';
end
btnPos=[x(2) y(7) w*.9 dy];
REMORA.spice_dt_mkTPWS.spNameEdTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',REMORA.spice_dt.mkTPWS.spName,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_TPWS_control(''setTPWSspName'')');

%% Min RL Text
labelStr = 'Min. Recieved Level (dBpp, optional)';
btnPos=[x(1) y(8) w*1.5 dy];
REMORA.spice_dt_mkTPWS.minRLTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

%  Min RL Editable Text
if ~isfield(REMORA.spice_dt.mkTPWS, 'minDBpp')
    REMORA.spice_dt.mkTPWS.minDBpp = '';
end
btnPos=[x(2)+w/2 y(8) w/2*.8 dy];
REMORA.spice_dt_mkTPWS.minRLEdTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','right',...
    'String',REMORA.spice_dt.mkTPWS.minDBpp,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_TPWS_control(''setTPWSminRL'')');

%% Max Rows Text
labelStr = 'Max. Detections Per File';
btnPos=[x(1) y(9) w*1.5 dy];
REMORA.spice_dt_mkTPWS.maxRowsTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

%  Max Rows Editable Text
if ~isfield(REMORA.spice_dt.mkTPWS, 'maxRows')
    REMORA.spice_dt.mkTPWS.maxRows = 1800000;
end
labelStr = '';
btnPos=[x(2)+w/2 y(9) w/2*.8 dy];
REMORA.spice_dt_mkTPWS.maxRowsEdTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','right',...
    'String',REMORA.spice_dt.mkTPWS.maxRows,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_TPWS_control(''setMaxRows'')');

%% Waveform max samples
labelStr = 'Waveform Length (Samples)';
btnPos=[x(1) y(10) w*1.5 dy];
REMORA.spice_dt_mkTPWS.tsWinTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

%  Max Rows Editable Text
if ~isfield(REMORA.spice_dt.mkTPWS, 'tsWin')
    REMORA.spice_dt.mkTPWS.tsWin = 200;
end
btnPos=[x(2)+w/2 y(10) w/2*.8 dy];
REMORA.spice_dt_mkTPWS.tsWinEdTxt = uicontrol(REMORA.fig.sp_dt_mkTPWS,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','right',...
    'String',REMORA.spice_dt.mkTPWS.tsWin,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_TPWS_control(''setTsWin'')');


%% Run make TPWS file
labelStr = 'Make TPWS Files';
btnPos=[.25 y(11) .5 1*h];
REMORA.spice_dt_mkTPWS.refresh = uicontrol(REMORA.fig.sp_dt_mkTPWS, ...
   'Style','pushbutton', ...
   'Units','normalized', ...
   'Position',btnPos, ...
   'BackgroundColor',bgColor3,...
   'String',labelStr, ...
   'FontUnits','points', ...
   'FontWeight','bold',...
   'FontSize',11,...
   'Callback','sp_dt_TPWS_control(''run_mkTPWS'')');

