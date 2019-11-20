function y = hhsv(N,n)
% Colormap

% AUTH: HM, 2016-10-31?

if nargin < 1, N = length(colormap); end
if nargin < 2, n = (1:N); end

X      = [0 1 2 3 4 5 6]/6;
Y(1,:) = [0 0 1 2 2 2 0]/2;    % RED
Y(2,:) = [0 0 1 2 1 0 0]/2;    % GREEN
Y(3,:) = [0 2 2 2 1 0 0]/2;    % BLUE

x = [0:N-1]/(N-1);
y = interp1(X',Y',x','linear');

y = y(n,:);
