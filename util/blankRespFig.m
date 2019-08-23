function S = blankRespFig(recordingType, contrastFlag)
    % BLANKRESPFIG  Regular response with stim figure
    % INPUT: recordingType: (ec, vc, ic) default extracellular
    %
    %   Oct2016 - SSP
    %   Mar2019 - SSP - Cleaned
    % ---------------------------------------------------------------------
    
    if nargin < 2
        contrastFlag = true;
    end
    if nargin < 1
        recordingType = 'extracellular';
    end

    S.fh = figure();
    set(S.fh, 'DefaultFigureColor', 'w',...
        'DefaultAxesTitleFontWeight', 'normal',...
        'DefaultLegendFontSize', 9,...
        'DefaultLegendEdgeColor', 'w',...
        'DefaultAxesTickDir', 'out',...
        'DefaultAxesBox', 'off');


    %S.Resp = subtightplot(10,1,1:7, 0.05,... 
    %    [0.05 0.08], [0.15 0.05], 'Parent', S.fh);
    S.Resp = subplot(10, 1, 1:7);
    hold(S.Resp, 'on');
    xlabel(S.Resp, 'time (s)');
    switch recordingType
        case {'extracellular', 'ec'}
            ylabel(S.Resp, 'amplitude (mV)');
        case {'voltage_clamp', 'vc'}
            ylabel(S.Resp, 'current (pA)');
        case 'ptsh'
            ylabel(S.Resp, 'spikes count');
        case 'raster'
            % ylabel(S.Resp, 'trials');
            figPos(S.fh, 0.85, 0.65);
            set(S.Resp, 'YTick', [], 'YColor', 'w', 'YTickLabel', {});
    end

    % S.Stim = subtightplot(5,1,5, 0.05,... 
    %     [0.05 0.08], [0.15 0.05], 'Parent', S.fh);
    S.Stim = subplot(5, 1, 5);
    hold(S.Stim, 'on');
    set(S.Stim, 'XColor', 'w', 'XTickLabel', {}, 'XTick', [],...
        'FontSize', S.Resp.FontSize);
    if contrastFlag
        ylabel(S.Stim, 'contrast');
        set(S.Stim, 'YLim', [-1 1]);
    else
        ylabel(S.Stim, 'intensity');
        set(S.Stim, 'YLim', [0 1]);
    end
