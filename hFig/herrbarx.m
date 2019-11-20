function h = herrbarx(x,y,varargin)
%[**1A++] Error bars in x (as single line).
% h = herrbarx(x(:,1:2),y(:,1),[LineSpec])
% herrbarx = @(x,y) plot(reshape((x(:,1,2,1)+[0,0,nan]).',[],1),reshape((y(:)+[0,0,nan]).',[],1))
% SEE ALSO: herrbar*.m

% AUTHOR: Hendrik Mandelkow, 2016

x = (x(:,[1,2,2])+[0,0,nan]).';
y = (y(:)+[0,0,nan]).';
hold on;
h = plot(x(:),y(:),varargin{:});
