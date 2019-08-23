function S = makeSpikeStimFigure(spikes, varargin)
    % MAKESPIKESTIMFIGURE
    %
    % History:
    %   23Aug2019 - SSP - wrote to mimic Igor function used in paper
    % ---------------------------------------------------------------------
    
    stimGen = StimulusGenerator(varargin{:});
    S = blankRespFig();
    
    ptsToTime = @(x) x / stimGen.sampleRate;
    plot(S.Resp, ptsToTime(1:numel(spikes)), spikes, 'k');
    xlim(S.Resp, [0, ptsToTime(numel(spikes))]);
    
    [stim, time] = stimGen.generate();
    plot(S.Stim, time, stim, 'k', 'LineWidth', 1.5);
    xlim(S.Stim, [0, max(time)]);
    
    figPos(gcf, 0.75, 1);