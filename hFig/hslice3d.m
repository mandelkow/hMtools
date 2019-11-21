function H = hslice3d(V)
%HSLICE3D Rotating MIP realized via transparent slice stacks.

% AUTHOR: Hendrik Mandelkow, 2016-06-15

[nx,ny,nz] = size(V);
% H = slice(V,1:nx,1:ny,1:nz);
tmp = (0:10)/10; H = slice(V,tmp*nx,tmp*ny,tmp*nz);
% set(H,'EdgeColor','none'); % alternative 'flat','interp', OR EdgeAlpha=0
[H.EdgeColor] = deal('none');
set(gcf,'Alphamap',linspace(0,0.7,64));
% for h=H(:)', h.AlphaData = h.CData; end
% set(H,{'AlphaData'},{H.CData}');
[H.AlphaData] = deal(H.CData);
[H.FaceAlpha] = deal('flat'); % Only now H.AlphaData is evaluated.

colormap([0 0 0]);
