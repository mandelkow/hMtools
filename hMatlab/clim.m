function hclim(ax,clim)
%[***1a+] Define missing CLIM like XLIM, YLIM,...
% clim([]) % = set(gca,'climmode','auto')
% clim([1 2]) % = set(gca,'clim',[1 2])
% clim(ax,[1 2]) % = set(ax,'clim',[1 2])
% SEE ALSO: XLIM YLIM

%% AUTHOR: Hendrik Mandelkow, 2018

if nargin < 2
  [ax,clim] = deal(gca,ax);
end
if isempty(clim)
  set(ax,'climmode','auto');
else
  set(ax,'clim',clim);
end
