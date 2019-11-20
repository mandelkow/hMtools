function cmap = hsummer(N,A,B)
% Colormap

% AUTHOR: Hendrik Mandelkow, 2011-08-24

if nargin < 1 || isempty(N),
  N = length(colormap);
end;
if nargin < 2,
  A = 1/3;
end;
if nargin < 3,
  B = 2/3;
end;

cmap = hcmapinterp(N,[[0,A,0];[1,1,B]]);

cmap(1,:) = 0;
cmap(end,:) = 1;
