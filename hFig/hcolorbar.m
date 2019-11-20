function [H,P] = hcolorbar(varargin)
%HCOLORBAR [2bc]
%
% AUTH: HM, 2012. 1st take, simply half the size.
% AUTH: HM, 2013. 2nd take.

try
	H = colorbar(varargin{:},'visible','off'); drawnow % error w Mat.2014b
catch
	warning('Old COLORBAR syntax not supported by Matlab >R2013b.');
	H = colorbar(varargin{:});
	return
end
P = get(H,'pos');
% if P(3) < P(4),
%     P(3) = P(3)/2;
% else
%     P(4) = P(4)/2;
% end

ax = handle(H); % See colorbar().
ax = get(ax,'Axes'); % Parent axes?!
ap = get(ax,'pos');

switch lower(get(H,'Location'))
    case 'east'
        P = P + P(3)/2*[2 0 -1 0];
        set(H,'pos',P);
    case 'west'
        P(3) = P(3)/2;
        set(H,'pos',P);
    case 'south'
        P(4) = P(4)/2;
        % P(2) = ap(2);
        set(H,'pos',P);
    case 'eastoutside'
        P = P + P(3)/2*[4 0 -1 0];
        set(H,'pos',P);
    case 'northoutside'
        P = P + P(4)/2*[0 6 0 -1];
        set(H,'pos',P);
    case 'north'
        P = P + P(4)/2*[0 2 0 -1];
        set(H,'pos',P);
    otherwise
end
set(H,'visible','on')
