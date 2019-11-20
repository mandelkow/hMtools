function H = haxlabel(Ax,Str,Loc,varargin)
%[*2B+] Add text to (top left) corner of axes.
%
% SYNTAX: H = haxlabel(Axes,String,'NW',['par',val,...])
% SEE ALSO: TEXT

% AUTHOR: Hendrik Mandelkow, 2006-02, v1A
% AUTH: HM, 02.2006, ver. 1A.
% AUTH: HM, 2012-12, ver. 2B.

if isempty(Ax), Ax = gca; end
if nargin<3 || isempty(Loc), Loc = 'NW'; end

switch upper(Loc),
    case 'NE',
        XY = [1,1];
    case 'SE',
        XY = [1,0];
    case 'SW',
        XY = [0,0];
    otherwise % NW
        XY = [0,1];
end
%%
dXY = [1 -1 0]; % margin?
HA = 'left';
VA = 'top';
if XY(1) > 0.5,
    HA = 'right';
    dXY(1) = -1;
end
if XY(2) < 0.5,
    VA = 'bottom';
    dXY(2) = 1;
end
%%
H = text(XY(1),XY(2),Str,'parent',Ax,'Units','normal','FontWeight','bold',...
    'HorizontalAlignment',HA,...
    'VerticalAlignment',VA,...
    'tag','haxlabel');
%%
FS = get(Ax,'FontSize');
set(H,'FontSize',FS+2);
set(H,'unit','point');
pos = get(H,'pos');
set(H,'pos',pos+dXY*FS/2);

set(H,'EdgeColor',get(H,'Color'));
set(H,'LineStyle','-','LineWidth',1);
set(H,'Background',get(Ax,'color'));
% set(H,'Margin',???);

if ~isempty(varargin), set(H,varargin{:}); end
set(H,'unit','normal');

