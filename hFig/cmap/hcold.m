function map = hcold(m,n)
%HCOLD Colormap, blue version of HOT.

% AUTHOR: Hendrik Mandelkow, 2015-03-19

if nargin < 1,
  m = length(colormap);
end;

map = hot(m);
%map = flipdim(map,2);
map = map(:,[3 2 1]);
if nargin>1
	map = map(n,:);
end
