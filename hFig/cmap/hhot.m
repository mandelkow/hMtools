function cmap = hhot(N,A,B)
% Colormap

% AUTHOR: Hendrik Mandelkow, 2006-08-26

if nargin < 1 || isempty(N),
  N = length(colormap);
end;
if nargin < 2,
  A = 0;
end;
if nargin < 3,
  B = 1;
end;

cmap = hcmapinterp(N,[[A,0,0];[1,0,0];[1,1,0];[1,1,B]],[A,1,2,2+B]);

cmap(1,:) = 0;
cmap(end,:) = 1;
