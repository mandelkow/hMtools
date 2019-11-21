function [H,X,Y] = htextile(A,T,XY,varargin)
%HTEXTILE [***1A++] Tile an axis with text labels on an XY grid.
%
% [H,X,Y] = htextile(gca,{'A','B','C'})
% [H,X,Y] = htextile(gca,{'A';'B';'C'})
% [H,X,Y] = htextile(gca,reshape(1:9,3,3),[1 1]/2,'horiz','center','vert','middle')
%
% SEE ALSO: hAxTileLabel hAxTileLabelXY, htextile, htextgrid

% AUTHOR: Hendrik Mandelkow, 2016-03-07, v1a.

if nargin<3 || isempty(XY), XY = [0 0]; end
if isnumeric(T), T = num2cell(T); end
if ischar(T), T = cellstr(T); end
XY(XY==0) = 0.0001; XY(XY==1) = 0.9999; % Avoid clipping problems!
[R,C] = size(T);
[X,Y] = meshgrid((0:C-1)/C+XY(1)/C,(0:R-1)/R+XY(2)/R);
X = X.*diff(A.XLim)+A.XLim(1);
Y = Y.*diff(A.YLim)+A.YLim(1);
% H = text(X(:),Y(:),T(:),varargin{:});
H = text(X(:),Y(:),T(:),'tag','htextile');
% set(H,'color','k','background','w','margin',0.1,'clipping','on');
set(H,'color',[1 1 1]/2,'background','none','margin',0.1,'clipping','on');
% HOWTO prevent text from showing outside the axes plotbox: Clipping = On.
set(H,'Horiz','left','Vertical','top');
if XY(1)>0.5, set(H,'Horizontal','right'); end
if XY(2)>0.5, set(H,'Vertical','bottom'); end
if nargin>3, set(H,varargin{:}); end
H = reshape(H,R,C);
