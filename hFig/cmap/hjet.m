function J = jet(m,k)
%hJET : Colormap JET with min & max replaced by black and white.
%   JET(M), a variant of HSV(M), is an M-by-3 matrix containing
%   the default colormap used by CONTOUR, SURF and PCOLOR.
%   The colors begin with dark blue, range through shades of
%   blue, cyan, green, yellow and red, and end with dark red.
%   JET, with no arguments, is the same length as the current colormap.
%   Use COLORMAP(JET).
%
%   See also HSV, HOT, PINK, FLAG, COLORMAP, RGBPLOT.

%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 5.7 $  $Date: 2002/04/01 21:01:50 $

% AUTH: HM, 2004-10-17, Upgrades.

if nargin < 1
   m = size(get(gcf,'colormap'),1);
end
n = ceil(m/4);
u = [(1:1:n)/n ones(1,n-1) (n:-1:1)/n]';
g = ceil(n/2) - (mod(m,4)==1) + (1:length(u))';
r = g + n;
b = g - n;
g(g>m) = [];
r(r>m) = [];
b(b<1) = [];
J = zeros(m,3);
J(r,1) = u(1:length(r));
J(g,2) = u(1:length(g));
J(b,3) = u(end-length(b)+1:end);

% HM! Colormap Jet with min and max replaced by black and white.
J(1,:) = [0 0 0];
J(end,:) = [1 1 1];
if nargin > 1,
    J = J(k,:);
end;
