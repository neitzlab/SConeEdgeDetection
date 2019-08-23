classdef StimulusGenerator < handle
    % STIMULUSGENERATOR
    %
    % Description:
    %   Generates sine and square-wave stimuli with the same input scheme
    %   as Symphony, but without depending on all the Symphony files
    %
    % Syntax:
    %   obj = StimulusGenerator(stimTime, varargin)
    %
    % History:
    %   19Feb2019 - SSP - Offline version of SineGenerator
    % ---------------------------------------------------------------------

    properties (SetAccess = private)
        preTime                 % ms
        stimTime                % ms
        tailTime                % ms
        period                  % ms
        temporalType
        amplitude               % contrast, LED voltage, etc...
        background              % contrast, LED voltage, etc...
        sampleRate              % hz
    end

    properties (Hidden, Constant)
        TEMPORAL_TYPES = {'sinewave', 'squarewave'};
    end

    methods 
        function obj = StimulusGenerator(stimTime, varargin)
            ip = inputParser();
            ip.CaseSensitive = false;
            addParameter(ip, 'preTime', 0, @isnumeric);
            addParameter(ip, 'tailTime', 0, @isnumeric);
            addParameter(ip, 'period', 500, @isnumeric);
            addParameter(ip, 'temporalType', 'squarewave',...
                @(x) ismember(lower(x), obj.TEMPORAL_TYPES));
            addParameter(ip, 'amplitude', 1, @isnumeric);
            addParameter(ip, 'background', 0, @isnumeric);
            addParameter(ip, 'sampleRate', 10000, @isnumeric);
            parse(ip, varargin{:});
            
            obj.stimTime = stimTime;
            params = fieldnames(ip.Results);
            for i = 1:numel(params)
                obj.(params{i}) = ip.Results.(params{i});
            end
        end

        function [data, time] = generate(obj, stimTime)
            % GENERATE  Returns the stimulus trace and time in seconds

            if nargin == 2
                obj.stimTime = stimTime;
            end

            prePts = obj.ms2pts(obj.preTime);
            stimPts = obj.ms2pts(obj.stimTime);
            tailPts = obj.ms2pts(obj.tailTime);

            data = ones(1, prePts + stimPts + tailPts) * obj.background;

            freq = 2 * pi / (obj.period * 1e-3);
            x = (0:stimPts-1)/obj.sampleRate;
            stim = obj.background + obj.amplitude * sin(freq * x);

            data(prePts+1 : prePts+stimPts) = stim;
            if strcmp(obj.temporalType, 'squarewave')
                data(data > obj.background) = max(data);
                data(data < obj.background) = min(data);
            end
            time = obj.pts2ms(numel(data));
        end
    end

    methods (Access = private)
        function x = pts2ms(obj, pts)

            if length(pts) > 1
                x = (1:length(pts));
            else
                x = 1:pts;
            end

            x = x / obj.sampleRate;
        end

        function pts = ms2pts(obj, ms)
            pts = round(ms / 1e3 * obj.sampleRate);
        end
    end
end