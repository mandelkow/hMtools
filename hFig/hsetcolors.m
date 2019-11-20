function hsetcolors(H,cmap)
% hsetcolors(H,cmap): Set color of multiple objects according to cmap.
% hsetcolors = @(H,cmap) set(H,{'color'},num2cell(cmap(1:numel(H),:),2));

% AUTHOR: Hendrik Mandelkow
set(H,{'color'},num2cell(cmap(1:numel(H),:),2));
