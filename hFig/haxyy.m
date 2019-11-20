function H = haxyy(H,varargin)
%[+2a2] Create double axes (right and top) see PLOTYY.
%
% USAGE: subplot(1,1,1); plot(1:10); haxyy(); plot(5:-1:1)

% AUTHOR: Hendrik Mandelkow, 2003-12
% AUTH: HM 07.2006, ver. 2a2. Assign and link PlotBoxAspectRatio.
% AUTH: HM 07.2006, ver. 2a1. Add linkaxes and linkprop.
% AUTH: HM 04.2006, ver. 1a2. Add varargin for parameters.
% AUTH: HM 09.2005, ver. 1a1.
% AUTH: HM 12.2003, ver. 1a.

if nargin < 1,
    H = gca;
end;

set(H,'box','off',...
    'nextplot','replacechildren',...  % i.e. don't change axes
    'activePositionProperty','position');
if 0,
%     h = copyobj(H,get(H,'parent'));
%     delete(get(h,'children'));
%     set(h,'tag','haxyy');
else,
    h = axes('tag','haxyy','parent',get(H,'parent'),'pos',get(H,'pos'),...
        'activePositionProperty','position');
    % BAD! set(h,'DataAspectRatio',get(H,'DataAspectRatio'));
    % BAD! set(h,'PlotBoxAspectRatio',get(H,'PlotBoxAspectRatio'));
end;
if strcmp(get(H,'xaxislocation'),'bottom'),
    set(h,'xaxisloc','top');
end
if strcmp(get(H,'yaxislocation'),'left'),
    set(h,'yaxisloc','right');
end
set(h,'color','none',...            % transparent background
    'nextplot','replacechildren',...% don't change axes properties
    ...'ycolor','b',...
    'box','off',...
    'xgrid','off',...
    'ygrid','off');
if ~isempty(varargin),
    set(h,varargin{:});
end
H = [H;h];
axes(h);    % Make 2nd axes current.

linkprop(H,'position');
linkaxes(H,'x');
% BAD!? linkprop(H,'PlotBoxAspectRatio');
