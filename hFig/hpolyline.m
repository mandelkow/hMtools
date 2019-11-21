function [h,P] = hlsline(H,p)
%HLSLINE [**1a++] Plot polynom. fit lines.
%
% USE: [h,P] = hlsline(H,p)
%   [FitLine(n),PolyCoeff(n,1:p)] = hlsline(LineObjects(n),PolyOrder_p)
%
% set(h,{'Color'},{H.Color}','LineWidth',2);
%
% SEE ALSO: hlsline.m

% AUTHOR: Hendrik Mandelkow, 2017-02, v1a

if nargin<1 || isempty(H), H = gca; end
if nargin<2, p = 1; end

H = findobj(H,'type','line'); % +++
for n=1:numel(H)
	P(n,:) = polyfit(H(n).XData,H(n).YData,p); % +++
	hold(H(n).Parent,'on');
	set(H(n).Parent,'xlimmode','manual','ylimmode','manual');
	% h(n) = ezplot(@(x) polyval(P(n,:),x),H(n).Parent.XLim);
	h(n) = fplot(@(x) polyval(P(n,:),x), H(n).Parent.XLim,'--');
	set(h(n),'Color',H(n).Color,'LineWidth',2);
end
% set(h,{'Color'},{H.Color}','LineWidth',2);
