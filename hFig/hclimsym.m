function [clim,olim] = hclimsym(ax,clim)
%HCLIMSYM [**1a] Clim symmetric about zero. [ClimNew,ClimOld] = hclimsym(ax,clim)
%
% set(gca,'clim',[-1 1].*max(abs(get(gca,'clim'))));

% AUTHOR: Hendrik Mandelkow, 2012, v.1a

if nargin < 1 || isempty(ax),
    ax = gca;
end
olim = get(ax,'clim');
try olim = cat(1,olim{:}); catch end
if nargin < 2 || isempty(clim),
    clim = max(abs(olim(:))).*[-1 1];
else
    clim = max(abs(clim(:))).*[-1 1];
end
set(ax,'clim',clim);
