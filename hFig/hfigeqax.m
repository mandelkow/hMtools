function hfigeqax(Hdl,ax)
%HFIGEQAX [**4A1+] Make all xy axes equal in scale.

% AUTHOR: Hendrik Mandelkow, 2000-10-22
% AUTH: HM, 22.10.00 ver.2A.
% AUTH: HM, 14.05.2004 ver.3A. Include Zlim and Clim.
% AUTH: HM, 06.05.2005 ver.4AB. Use 2nd input.
% AUTH: HM, 2019-05-07 ver.4AB1. use for loop

minmax = @(x) [min(x),max(x)]

if (nargin < 1), Hdl = gcf; end;
Ax = findobj(Hdl,'type','axes','-not','tag','Colorbar','-not','tag','legend');
if length(Ax) < 2, return; end
if nargin < 2,
    ax = Ax;
else
    ax = findobj(ax,'type','axes');
end
for V = {'xlim','ylim','zlim','clim'}
	v = get(ax(:),V);
	v = minmax([v{:}]);
	set(Ax,V,v)
end

% Xlim = get(ax(:),'xlim');
% Xlim = minmax([Xlim{:}]);
% Ylim = get(ax(:),'ylim');
% Ylim = minmax([Ylim{:}]);
% Zlim = get(ax(:),'zlim');
% Zlim = minmax([Zlim{:}]);
% Clim = get(ax(:),'clim');
% Clim = minmax([Clim{:}]);
% set(Ax, 'Xlim', Xlim, 'Ylim', Ylim, 'Zlim', Zlim, 'Clim', Clim);
