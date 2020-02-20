classdef aux
    %% This is just a namespace that holds tools to help make figures prettier
    %% and easier to use.
    
    methods (Static = true)
        function Fix
            set(gca, ...
                'Box'         , 'off'     , ...
                'TickDir'     , 'out'     , ...
                'TickLength'  , [.005 .005] , ...
                'YMinorTick'  , 'off'      , ...
                'XColor'      , [.3 .3 .3], ...
                'YColor'      , [.3 .3 .3], ...
                'XMinorTick'  , 'on'      , ...
                'LineWidth'   , 1         );
            
            set(gca, 'FontName', 'Calibri Light', 'FontSize', 12);
            set(gcf, 'color', [1 1 1]);            
        end
        
        function h = HLine(Y, varargin)
            % HLine(Y, varargin) draws a horizontal line on the current axes
            a = axis;
            t = strcmpi(varargin, 'text');
            if any(t)
                str = [' ' varargin{find(t)+1}];
                varargin(find(t)) = [];
            else
                str = '';
            end
            if nargin >= 2
                %line([a(1), a(2)], [Y Y], varargin{:});
                h = zeros(1, length(Y));
                for i=1:length(Y)
                    y = Y(i);
                    h(i) = line([a(1), a(2)], [y, y], varargin{:});
                    if ~isempty(str)
                        text(a(2), y, str, 'HorizontalAlignment', 'left', 'verticalalignment', 'top', 'color', get(h(i), 'color'));
                    end
                end
            else
                %                line([a(1), a(2)], [Y Y], 'LineStyle', ':', 'Color', 'k');
                h = zeros(1, length(Y));
                for i=1:length(Y)
                    y = Y(i);
                    h(i) = line([a(1), a(2)], [y, y], 'LineStyle', ':', 'Color', 'k');
                    if ~isempty(str)
                        text(a(2), y, str, 'HorizontalAlignment', 'left', 'verticalalignment', 'top', 'color', get(h(i), 'color'));
                    end
                end
                
            end
        end
        
        function h = VLine(X, varargin)
            % VLine(X, varargin) draws a vertical line on the current axes
            % VLine(X, 'text', text, varargin) draws a vertical line on the
            % current axes and adds text
            a = axis;
            t = strcmpi(varargin, 'text');
            if any(t)
                str = [' ' varargin{find(t)+1}];
                varargin([find(t) find(t)+1]) = [];
            else
                str = '';
            end
            if nargin >= 2
                h = zeros(1, length(X));
                for i=1:length(X)
                    x = X(i);
                    h(i) = line([x, x], [a(3) a(4)], varargin{:}, 'HandleVisibility','off');
                    if ~isempty(str)
                        text(x, a(4), str, 'HorizontalAlignment', 'left', 'verticalalignment', 'top', 'color', get(h(i), 'color'));
                    end
                end
            else
                h = zeros(1, length(X));
                for i=1:length(X)
                    x = X(i);
                    h(i) = line([x, x], [a(3) a(4)], 'LineStyle', ':', 'Color', 'k');
                    if ~isempty(str)
                        text(x, a(4), str, 'HorizontalAlignment', 'left', 'verticalalignment', 'top');
                    end
                end
            end
        end
    end
end