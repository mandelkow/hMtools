function x = hmovmean(x,n,d)
%[**2B1++] Moving nanmean filter of N points.
%
% SYNTAX: Y = hmovmean( X, N, Dim)
%
% If N<0 : X = circshift(X,floor(N/2),Dim) will remove lag for odd N.

% PREC: hMovAvg.m
% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2013-06, v.1B
%
% TODO:
% * Make symmetric for neg or odd input (see hmovavg)
% * Condition end effects (see hmovavg)

% Anonymous function implementation: DOESN'T WORK LIKE THAT!
% hmmean= @(x,n,d) filter(ones(n,1),1,x,[],d)./filter(ones(n,1),1,~isnan(x),[],d);

if nargin<3, d = find(size(x)>1,1); end
if n<0, n = abs(n); c = floor(n/2);
else c = 0;
end
xi = isnan(x);
x(xi) = 0;
x = filter(ones(n,1),1,x,[],d);
x = x ./ filter(ones(n,1),1,~xi,[],d);
if any(isnan(x(:))),
    warning('NaN results indicate periods without any data.');
end
if c,
	% WRONG! x = circshift(x,[zeros(1,d-1),c]);
	x = circshift(x,-c,d);
end
