function Hdl = hvline(X, varargin)
%HVLINE [****1a] Add vertical lines to current axes.
%
% USAGE:	Hdl = hline(X, varargin)
%
%			X = Vector of horizontal positions of lines in data units.
%			varargin = list of line property & value pairs to be set for all lines.
%
%			Hdl = Vector of handles to the lines drawn.
%
%% Matlab 2018:
% hxline = @(X,varargin) plot([1;1]*X(:).',(ylim).',varargin{:})
%
% SEE ALSO: hxline, hyline, hhline, hcolstyle

% AUTHOR: Hendrik Mandelkow, 2000 AD
% AUTH: HM 21.07.00, ver 1A.
% AUTH: HM 15.03.01, ver 1A1. Added Tag.
% AUTH: HM 09.09.2004, ver 1A2. Added hcolstyle.
% AUTH: HM, 2018-10-11, v.1A4: Renamed vars properly.

if isempty(X)
  warning('Empty input X.');
  Hdl = [];
  return
end
% X = [X(:),X(:)].';	% =X(2,:)
% Y = get(gca, 'ylim');
% Y = repmat(Y(:),1,size(X,2));
tmp = get(gca,'NextPlot');
set(gca,'NextPlot','add');
% Hdl = line(X,Y); % might use plot + hold?!
Hdl = plot([1;1]*X(:).',(ylim).'); % Matlab 2018!
set(gca,'NextPlot',tmp);
set(Hdl, 'tag','hvline','color','g','linestyle','--');		% default
if nargin > 1,
    % set(Hdl, varargin{:});
    hcolstyle(Hdl,varargin{:});
end
