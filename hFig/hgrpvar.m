function g = hgrpvar(n,m)
% Make grouping variable for boxplot
% n = number of consecutive members in each group
% m = label for each group

% AUTHOR: Hendrik Mandelkow, 2015-09-22

g(cumsum([1;n(:)])) = 1;
g = cumsum(g(1:end-1));
if nargin>1,
	g = m(g);
end
g = g(:);
