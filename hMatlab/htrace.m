function T = htrace(X,n)
%[**] Side-diagonal trace(s)
if nargin<2,
	N = size(X,1);
	n = -N+1:N-1;
end
T = [];
for n=n(:)',
	T(end+1) = sum(diag(X,n));
end
