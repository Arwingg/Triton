function mdLTSA_init_batch_figure

global REMORA

defaultPos = [0.25,0.25,0.3,0.6];
REMORA.fig.mdLTSA.batch = figure( ...
    'NumberTitle','off', ...
    'Name','Batch Create LTSAs',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on');

% % Detection Settings pulldown
% REMORA.bm.menuBatch = uimenu(REMORA.fig.bm.batch,'Label','&Load Settings',...
%     'Enable','on','Visible','on');

% % Spectrogram load/save params
% uimenu(REMORA.bm.menuBatch,'Label','&Select Detector Settings File',...
%     'Callback','bm_gui_pulldown(''settingsLoadBatch'')');
