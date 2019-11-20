function h = herrbarxt(y,x,varargin)
%[**1A++] Error bars in X with T caps.
% h = herrbar(x(:,1:2),y(:,1),[LineSpec])
% x = [x(:)-dx, x(:)+dx]
% y(:) = y(x(:))
% Same code as hErrBart with the roles of x and y reversed.
% SEE ALSO: herrbar*.m

% AUTHOR: Hendrik Mandelkow, 2016
% AUTH: HM, 2016-04-30, v1a: Forked from herrbart.m

dy = diff(y,1,2);
dx = max(dy)/10; % *** Crossbar fraction of max errorbar.

x = bsxfun(@plus,x(:),dx.*[0 0 nan -1 1 nan -1 1 nan]).';
y = bsxfun(@plus,y(:,1),dy*[0 1 nan 0 0 nan 1 1 nan]).';

hold on;
h = plot(y(:),x(:),varargin{:});
