%% S-OFF midget electrophysiology
%
% Depends on functions in the util and lib folders, so make sure to add
% those to Matlab's search path.
%
% August 2019 - SSP
% -------------------------------------------------------------------------

% Set "..." to wherever SConeEdgeDetection repository is saved
dataDir = '...\SConeEdgeDetection\data\physiology\';

filters = dlmread([dataDir, 'soff_midget_linear_filters.txt']);

ax = axes('Parent', figure()); 
hold(ax, 'on');
set(ax, 'TickDir', 'out', 'Box', 'off');
axis(ax, 'square');

time = linspace(0, 200, size(filters, 1)+1);
plot(ax, time, zeros(size(time)), '--', 'Color', [0.5, 0.5, 0.5]);
for i = 1:size(filters, 2)
    plot(ax, time(2:end), filters(:, i), 'b');
end
plot(ax, time(2:end), mean(filters, 2), 'k', 'LineWidth', 2);
ylim(ax, [-1, 1]); xlim(ax, [0, 200]);
figPos(ax.Parent, 0.6, 0.6); tightfig(ax.Parent);