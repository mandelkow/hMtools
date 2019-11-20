function x = hrss(x, dim)
%HRSS Root sum of squares: y = sqrt(hsum(abs(x).^2, dim));
% SEE ALSO: RMS()

% AUTHOR: Hendrik Mandelkow

if nargin>1
  x = sqrt(hsum(abs(x).^2, dim));
else
  x = sqrt(sum(abs(x).^2));
end

function x = hsum(x,d)
if nargin>1
  for d = d(:)'
    x = sum(x,d);
  end
else
  x = sum(x);
end
