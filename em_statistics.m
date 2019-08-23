%% Serial EM statistics and analysis
% June 2018 - SSP
%
% Contents:
%   - Bootstrap analysis on two groups of L/M-cone midget bipolars
%   - Midget bipolar-ganglion cell cell ribbon synapse counts
%   - Low dimensional space for distinguishing H1 and H2 horizontal cells 
%       from preliminary reconstructions.
%   - Midget bipolar cell soma sizes
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
%% L/M-cone ribbon synapse bootstrap analysis
% -------------------------------------------------------------------------

% L/M-cone midget bipolar -> ganglion cell ribbon synapse counts
ribbonCounts = [39, 40, 40, 51, 51, 52, 53];

% Bootstrap analysis procedure
% 1. The mean and standard deviation of data as a single group
muAll = mean(ribbonCounts);
sdAll = std(ribbonCounts);
% 2. Divide the data into 2 groups, over and under the mean
over = ribbonCounts(ribbonCounts >= mean(ribbonCounts));
under = ribbonCounts(ribbonCounts < mean(ribbonCounts));
% 3. Find the mean and standard deviation of each group
muOver = mean(over);
sdOver = std(over);
muUnder = mean(under);
sdUnder = std(under);

% The number of bootstrap runs
nRuns = 1000;

for i = 1:nRuns
    % Draw from the normal distribution assuming original data was 1 group
    % Round because you can't have half a ribbon synapse
    x = round(normrnd(muAll(1), sdAll(1), size(ribbonCounts)));

    % 1. Take the group mean and standard deviation
    muAll = cat(1, muAll, mean(x));
    sdAll = cat(1, sdAll, std(x));

    % 2. Divide into two groups over and under the mean
    over = x(x >= mean(x));
    under = x(x < mean(x));

    % 3. Get the mean and standard deviation of the resulting groups
    muOver = cat(1, muOver, mean(over));
    sdOver = cat(1, sdOver, std(over));
    muUnder = cat(1, muUnder, mean(under));
    sdUnder = cat(1, sdUnder, std(under));
end

% Note: For each array produced, the first entry is the original data

% The average standard deviations of the two groups. This is expected to be
% large if just arbitrarily dividing a normally distributed dataset into 
% two groups. However, if the dataset is binomially distributed, the SD of
% each group is expected to be very small (as is observed in Figure 3G).
sdAvg = (sdOver + sdUnder)/2;


% Find the number of samples higher than the original datasets SD average.
numOverSD = numel(find((sdAvg > sdAvg(1))));
fprintf('%u of %u with greater average SDs than dataset\n',... 
    numOverSD, nRuns);
pValue = 1-(numOverSD/nRuns);
fprintf('p = %.4f\n', pValue);


% -------------------------------------------------------------------------
%% Primary dendrite diameter - H1 vs H2
% -------------------------------------------------------------------------

h1_dendriteDiameter = [0.56, 0.68, 0.6, 0.64, 0.62, 0.66];  % microns
printStat(h1_dendriteDiameter)
% 0.627 +- 0.018 (n=6)
h2_dendriteDiameter = [0.44, 0.42, 0.44, 0.44, 0.5, 0.46];  % microns
printStat(h2_dendriteDiameter)
% 0.450 +- 0.011 (n=6)
[p, ~] = ranksum(h1_dendriteDiameter, h2_dendriteDiameter);
disp(p);  % p = 0.0022

% -------------------------------------------------------------------------
%% Soma size - H1 vs H2
% -------------------------------------------------------------------------
h1_somaDiameter = [9.556, 9.24, 8.98, 8.6, 9.334, 9.18];
h2_somaDiameter = [8.9103, 7.3798, 8.335, 8.03, 8.414, 8.4857];
printStat(h1_somaDiameter);
% 9.148 +- 0.134 (n=6)
printStat(h2_somaDiameter);
% 8.259 +- 0.211 (n=6)
[p, h] = ranksum(h1_somaDiameter, h2_somaDiameter);
disp(p);  % p = 0.0043

% -------------------------------------------------------------------------
%% H1 vs H2 criteria graph
% -------------------------------------------------------------------------
% Two parameters enabling early identification of H1 vs H2 HCs
figure(); hold on;
plot(h1_dendriteDiameter, h1_somaDiameter, 'o',... 
    'Color', [1, 0.25, 0.25], 'MarkerFaceColor', [1, 0.25, 0.25]);
plot(h2_dendriteDiameter, h2_somaDiameter, 'o',... 
    'Color', [0, 0.8, 0.3], 'MarkerFaceColor', [0, 0.8, 0.3]);
xlabel('Primary dendrite diameter');
ylabel('Soma diameter');
legend('H1', 'H2');

% -------------------------------------------------------------------------
%% Midget bipolar cell soma sizes
% -------------------------------------------------------------------------

% L/M-OFF midget bipolar cell soma diameters
lmSomas = [7.5887, 8.1018, 8.4394, 7.8097, 7.8151, 8.1658, 8.2219];

% S-OFF midget bipolar cell soma diameters
sSomas = [7.7975, 7.5519, 7.4111, 7.3185, 7.3289, 7.6727, 8.1267];

% Test the difference between the two groups
[pValue, statSig] = ranksum(lmSomas, sSomas);
if statSig
    fprintf('p = %.4f\n', pValue);
else
    fprintf('Not statistically significant, p = %.4f\n', pValue);
end
% LM-cone OFF midget BC soma diameter is significantly larger than S-cone
% OFF midget BC somas (p = 0.0175)
