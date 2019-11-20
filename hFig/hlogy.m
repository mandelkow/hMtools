function hlogy(h)
% Toggle axes yscale log/lin.
%
% hlogy = @(h) set(findobj(h,'type','axes'),'yscale','log')

% AUTHOR: Hendrik Mandelkow

if nargin<1 || isempty(h)
    h = gca;
end
h = findobj(h,'type','axes');
n = strncmp(get(h,'yscale'),'log',3);
set(h(~n),'yscale','log');
set(h(n),'yscale','lin');
