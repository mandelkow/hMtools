function hlogx(h)
% Toggle axes xscale log/lin.
%
% hlogx = @(h) set(findobj(h,'type','axes'),'xscale','log')

% AUTHOR: Hendrik Mandelkow

if nargin<1 || isempty(h)
    h = gca;
end
h = findobj(h,'type','axes');
n = strncmp(get(h,'xscale'),'log',3);
set(h(~n),'xscale','log');
set(h(n),'xscale','linear');
