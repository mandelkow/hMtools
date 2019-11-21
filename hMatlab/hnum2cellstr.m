function C = hnum2cellstr(X,F)
%  C = strtrim(cellstr(num2str(X(:),F)));
% EXAMPLE: plot(rand(3)); legend( hnum2cellstr(1:3,'Group %u') )

% AUTHOR: Hendrik Mandelkow, 2016-02-01

C = strtrim(cellstr(num2str(X(:),F)));
