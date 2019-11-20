function haxtilelabelxy(Ax,RC,Lab,yLab)
%HAXTILELABELXY [1b+] Apply X/YTickLabel from string matrix Lab{R,C} to axes.
% function HAXTILELABELXY(Ax,RC,Lab,yLab)
%
% set(Ax,'xlabel',Lab(1:RC(2)),'ylabel',Lab(1:RC(2):prod(RC)))
%
%ax1.XTick = ax.XLim(1)+([1:RC(2)]-0.5)*diff(ax.XLim)/RC(2);
%ax1.YTick = ax.YLim(1)+([1:RC(1)]-0.5)*diff(ax.YLim)/RC(1);

% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2004, v1b

ax = get(Ax);
if isempty(RC),
	RC = [length(ax.YTick),length(ax.XTick)];
end;
if nargin < 4,
	yLab = Lab(1:RC(2):prod(RC));
end
xLab = Lab(1:RC(2));
if 1 % changed 0->1 on 20151213
	ax1.XTick = ax.XLim(1)+([1:RC(2)]-0.5)*diff(ax.XLim)/RC(2);
	ax1.YTick = ax.YLim(1)+([1:RC(1)]-0.5)*diff(ax.YLim)/RC(1);
end
% Probably don't need this conversion to string.
% if isnumeric(xLab),
% 	ax1.XTickLabel = num2str(xLab','%.2f');
% end;
% if isnumeric(yLab),
% 	ax1.YTickLabel = num2str(yLab','%.2f');
% end;

set(Ax,ax1);

