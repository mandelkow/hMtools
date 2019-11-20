function y = bwr(N)
%hcm.bwr(N) Colormap blue-white-read.
% SEE ALSO: HBWR

% PREC: HBWR, HCMAP_BWR
% AUTH: HM, <2017

if nargin < 1,
  N = length(colormap);
end;

X      = [0 1 2 3 4 5 6]/6;
Y(1,:) = [0 0 1 2 2 2 1]/2;    % RED
Y(2,:) = [0 0 1 2 1 0 0]/2;    % GREEN
Y(3,:) = [1 2 2 2 1 0 0]/2;    % BLUE

x = [0:N-1]/(N-1);
y = interp1(X',Y',x','linear');

hclimsym;
