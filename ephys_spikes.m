%% S-OFF midget electrophysiology
%
% Depends on functions in the util and lib folders, so make sure to add
% those to Matlab's search path.
%
% July 2019 - SSP
% -------------------------------------------------------------------------

% Set "..." to wherever SConeEdgeDetection repository is saved
dataDir = '...\SConeEdgeDetection\data\physiology\';

%% Basic parameters
sampleRate = 10000;  % Hz
timeToPts = @(x) round(x / 1e3 * sampleRate);
ptsToTime = @(x) x / sampleRate;

%% Cell One
spikes = dlmread([dataDir, 'soff_midget_spikes_cell1.txt']);
S = makeSpikeStimFigure(spikes, 1000, 'period', 500, ...
    'preTime', 200, 'tailTime', 200);

%% Cell Two
spikes = dlmread([dataDir, 'soff_midget_spikes_cell2.txt']);
S = makeSpikeStimFigure(spikes, 1000, 'period', 500, ...
    'preTime', 200, 'tailTime', 200);

%% Cell Three
spikes = dlmread([dataDir, 'soff_midget_spikes_cell3.txt']);
S = makeSpikeStimFigure(spikes, 2000, 'period', 1000, ...
    'preTime', 200, 'tailTime', 200);

%% OFF parasol control
% Achromatic
spikes = dlmread([dataDir, 'off_parasol_spikes_achromatic.txt']);
S = makeSpikeStimFigure(spikes, 1000, 'period', 500, ...
    'preTime', 200, 'tailTime', 200);

% S-cone isolating
spikes = dlmread([dataDir, 'off_parasol_spikes_sconeisolating.txt']);
S = makeSpikeStimFigure(spikes, 1000, 'period', 500, ...
    'preTime', 200, 'tailTime', 200);
ylim(S.Resp, [-100, 80]);  % Set to match achromatic response

%% Expanding spots
spikes = dlmread([dataDir, 'soff_midget_spikes_cell4_smallspot.txt']);
S = makeSpikeStimFigure(spikes, 2500,...
    'preTime', 500, 'tailTime', 500, 'period', 500);
title(S.Resp, '36 micron spot');

spikes = dlmread([dataDir, 'soff_midget_spikes_cell4_fullfield.txt']);
S = makeSpikeStimFigure(spikes, 2500,...
    'preTime', 500, 'tailTime', 500, 'period', 500);
title(S.Resp, 'full field');