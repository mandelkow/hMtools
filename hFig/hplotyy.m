function [Ax,H,H2] = hplotyy(varargin)
% hPlotYY 1ab: Simpler syntax for PLOTYY() - hPlotYY(Y1,Y2).
% AUTH: HM, 2011-12

switch nargin
    case 2
        [Y1,Y2] = deal(varargin{:});
        [X1,X2] = deal(1:length(Y1),1:length(Y2));
        [Ax,H1,H2] = plotyy(X1,Y1,X2,Y2);
    case 3
        [X1,Y1,Y2] = deal(varargin{:});
        X2 = X1;
        [Ax,H1,H2] = plotyy(X1,Y1,X2,Y2);
    otherwise
        [Ax,H1,H2] = plotyy(varargin{:});
end
if nargout < 3
    H = [H1,H2];
else
    H = H1;
end

% plotyy(X1,Y1,X2,Y2,varargin{:});
