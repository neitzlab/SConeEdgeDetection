%% Serial EM reconstructions
%
% Units along the x, y and z axes are microns
%
% Dependencies:
%   SBFSEM-tools (https://github.com/neitzlab/sbfsem-tools)
%
% July 2019 - SSP
% -------------------------------------------------------------------------

% Set "..." to wherever SConeEdgeDetection repository is saved
dataDir = '.../SConeEdgeDetection/data/anatomy/';

% -------------------------------------------------------------------------
%% L/M-cone and S-cone OFF midget bipolar cell circuits
% -------------------------------------------------------------------------
c1411 = NeuronJSON([dataDir, 'i1411.json']);
c1441 = NeuronJSON([dataDir, 'i1441.json']);

c1441.render('FaceColor', hex2rgb('334de6'), 'FaceAlpha', 0.6);
c1411.render('ax', gca, 'FaceColor', [0.7, 0.25, 1], 'FaceAlpha', 0.6);
view(17, 0); grid on;

% -------------------------------------------------------------------------
%% H1 and H2 horizontal cells
% -------------------------------------------------------------------------
c619 = NeuronJSON([dataDir, 'i619.json']);
c2795 = NeuronJSON([dataDir, 'i2795.json']);

c619.render('FaceColor', [0, 0.8, 0.3], 'FaceAlpha', 0.6);
c2795.render('ax', gca, 'FaceColor', hex2rgb('ff4040'), 'FaceAlpha', 0.6);
grid on;