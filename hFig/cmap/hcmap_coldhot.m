function map = hhsv(m,n)
% Colormap

% AUTHOR: Hendrik Mandelkow, 2015-08-09

if nargin < 1,
  m = length(colormap);
end;

map = hcold(ceil(m/2));
map = [map;flipud(hot(m-size(map,1)))];
%map = map(:,[1 3 2]);
if nargin>1,
	map = map(n,:);
end
if nargout<1,
	colormap(map);
end
