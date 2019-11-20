function h = herrbar(x,y,varargin)
%[**1A++] Single-line errorbars without T.
% h = herrbar(x(:,1),[Ymin(:,1),Ymax(:,1)],[LineSpec])
%
% SEE ALSO: herrbart (with T-bars)

% AUTHOR: Hendrik Mandelkow, 2016-04 

if isempty(x), x = (1:length(y)).'; end
x = x(:);
if size(y,2)~=2
	warning('Expecting matrix y = [Ymin(:,1),Ymax(:,1)].');
	y = y.'; % try this...
end
x = [x x x*nan].';
y = [y y(:,1)*nan].';
hold on;
h = plot(x(:),y(:),varargin{:});
h.Tag = 'herrbar';
