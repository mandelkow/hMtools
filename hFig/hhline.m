function Hdl = hhline(Y, varargin)
%HHLINE [****1a] Add horizontal lines to current axes.
%
% USAGE:	Hdl = hhline(Y,varargin)
%
%			Y = Vector of vertical positions of lines in data units.
%			varargin = list of line property & value pairs to be set for all lines.
%
%			Hdl = Vector of handles to the lines drawn.
%
%% Matlab 2018:
% hxline = @(Y,varargin) plot((xlim).',[1;1]*Y(:).',varargin{:})
%
% SEE ALSO: hxline, hyline, hvline, hcolstyle

% AUTHOR: Hendrik Mandelkow, 2000 AD
% AUTH: HM 21.07.00, ver 1A.
% AUTH: HM 15.03.01, ver 1A1. Added Tag.
% AUTH: HM 09.09.2004, ver 1A2. Added hcolstyle.
% AUTH: HM 15.03.2006, ver 1A3. Use plot and new lineseries object.
% AUTH: HM, 2018-10-11, v.1A4: Renamed vars properly.

if isempty(Y)
  warning('Empty input Y.');
  Hdl = [];
  return
end
% Y = [Y(:),Y(:)].';	% Y(2,:)
% X = repmat(get(gca,'xlim').',1,size(Y,2));
% old: Hdl = line(ydat,xdat);
tmp = get(gca,'NextPlot');
set(gca,'NextPlot','add');
% Hdl = plot(X,Y);
Hdl = plot((xlim).',[1;1]*Y(:).'); % Matlab 2018!
set(gca,'NextPlot',tmp);
set(Hdl,'tag','hhline','color','g','linestyle','--');		% default
if nargin > 1,
    % set(Hdl, varargin{:});
    hcolstyle(Hdl,varargin{:});
end
