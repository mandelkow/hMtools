function y = hmovmax(x,N,P)
%[*1A-] Moving maximum y = hmovmax(x,N,P) -> y(n) = max(x(n-P:n-P+N))
% If N = 2*P+1 the intervall is centered around n.
%
% ++++ NB: HOWTO approximate a moving maximum filter (elegantly?):
% mmax = filter(ones(1,N)/N,1,abs(X).^p).^(1/p)
% Where p is as large as possible.
% SEE ALSO: hmovavg

%% AUTHOR: Hendrik Mandelkow

if N<0,
	P = abs(N);
	N = 2*P+1;
elseif nargin < 3,
    P = 0;
end;

sz = size(x);
x = x(:);

x = [ones(P,1)*NaN;x];  % Prepad.

M = rem(length(x),N);
if M,
    M = N-M;
    x = [x;ones(M,1)*NaN];
end;
y = ones(size(x))*NaN;
for n = 1:N,
    x = reshape(x,N,[]);
    y(n:N:end) = max(x);
    x = [x([2:end]');NaN];
end;
y(end-P+1:end) = [];
y = reshape(y(1:prod(sz)),sz);

return;

%%% TEST:
x = rand(210,1);
P = 1
N = 2*P+1
y = hmovmax(x,N,P);
plot([x,y])
