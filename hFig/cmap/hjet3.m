function y = hhsv(N,Y,X)
% Colormap

% AUTHOR: Hendrik Mandelkow, 2006-08-26

if nargin < 1,
  N = length(colormap);
end;
if nargin < 2,
    Y(1,:)      = [0 0 1];   % [R,G,B]
    Y(end+1,:)  = [0 1 1];
    Y(end+1,:)  = [1 1 0];
    Y(end+1,:)  = [1 0 0];
end
if nargin < 3,
    X = size(Y,1);
    X = [0:X-1].'./(X-1);
end
x = [0:N-1]/(N-1);
y = interp1(X,Y,x,'linear');
y = abs(y); % catch interpolation errors.

y(1,:) = 0;
y(end,:) = 1;
