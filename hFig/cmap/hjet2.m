function cmap = hhsv(N,S,V)
% Colormap

% AUTHOR: Hendrik Mandelkow, 2006-08-26

if nargin < 1 || isempty(N),
  N = length(colormap);
end;
if nargin < 2,
    S = 1;
end
if nargin < 3,
    V = 1;
end

cmap = [N-1:-1:0]./(N-1)*2/3;
cmap = cmap(:);
cmap(:,2) = S;
cmap(:,3) = V;
cmap = hsv2rgb(cmap);

cmap(1,:) = 0;
cmap(end,:) = 1;
