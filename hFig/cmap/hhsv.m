function map = hhsv(m)
% Colormap

% AUTH: HM, 2004-09-23

if nargin < 1,
  m = length(colormap);
end;

map = hcold(ceil(m/2));
map = [map;flipud(hot(m-size(map,1)))];

%map = map(:,[1 3 2]);
