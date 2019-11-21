function [h,P,S] = hlsline(H,p)
%HLSLINE [**1a1++] Plot polynom. fit lines.
%
% USE: [LineHandles,PolyCoeffs,PolyStats] = hlsline(H,p)
%   [FitLine(n),PolyCoeff(n,1:p)] = hlsline(LineObjects(n),PolyOrder_p)
%
% set(h,{'Color'},{H.Color}','LineWidth',2);
%
% SEE ALSO: hpolyline.m

% AUTHOR: Hendrik Mandelkow, 2017-02, v1a

if nargin<1 || isempty(H), H = gca; end
if nargin<2, p = 1; end

% H = findobj(H,'type','line'); % +++
H = findobj(H,'type','line','-or','type','scatter'); % +++
% H = findobj(H,'-regexp','type','(line|scatter)'); % Why this no work?!
if isempty(H), warning('No lines found!?'); end
for n=1:numel(H)
	if nargout < 3
		P(n,:) = polyfit(H(n).XData,H(n).YData,p); % +++
	else
		[P(n,:),S(n)] = polyfit(H(n).XData,H(n).YData,p); % +++
		% H0 cov(P): C = inv(S.R); C = (C*C')*S.normr^2/S.df
	end
	hold(H(n).Parent,'on');
	set(H(n).Parent,'xlimmode','manual','ylimmode','manual');
	% h(n) = ezplot(@(x) polyval(P(n,:),x),H(n).Parent.XLim);
	h(n) = fplot(@(x) polyval(P(n,:),x), H(n).Parent.XLim,'--k','LineWidth',1);
	try set(h(n),'Color',H(n).Color); catch, end
  if p==1 % && nargout>2
    [R,pval] = corr(H(n).XData(:),H(n).YData(:));
    h(n).UserData.R = R;
    h(n).UserData.p = pval;
  end
end
% set(h,{'Color'},{H.Color}','LineWidth',2);
