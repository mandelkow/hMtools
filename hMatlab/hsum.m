function x = hsum(x,d)
%HSUM [**1a++] Sum over multiple dimensions.
% x = sum(x,[1 2 3]); % <=>
% for d=[1 2 3], x = sum(x,d); end

% AUTHOR: Hendrik Mandelkow

if nargin>1
  for d = d(:)'
    x = sum(x,d);
  end
else
  x = sum(x);
end
