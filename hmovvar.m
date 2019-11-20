function [S,M] = hmovvar(X, N, Dim)
%[**2A+] Moving average filter of 2*N+1 points (symmetric).
%
% SYNTAX: [S,M] = hMovStd( X, N, Dim)
%
% SEE: hMovAvg

%% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 11.2007, v1b


if nargin < 3 || isempty(Dim),
    Dim = find(size(X)>1,1);
end;
if Dim ~= 1,
    PER = [1:ndims(X)];
    PER([1,Dim]) = [Dim,1];
    X = permute(X,PER);
end
Xsz = size(X);
X = X(:,:);

M = zeros(size(X));
S = zeros(size(X));
X = [X(N+1:-1:2,:);X;X(end-1:-1:end-N,:)];
if 1
    for n=1:size(S,1),
        M(n,:) = sum(X(n:n+2*N,:))./(2*N+1);
        % S(n,:) = sum((X(n:n+2*N,:)-repmat(M(n,:),[2*N+1,1])).^2)./(2*N+1);
        S(n,:) = sum(bsxfun(@minus,X(n:n+2*N,:),M(n,:)).^2)./(2*N+1);
    end
else
    %% TEST / ALTERNATIVE - OK!
    X = hdatwin(X,2*N+1,1);
    [S,M] = hstd(X,1);
    S = S.^2;
end

%%
clear X
S = reshape(S,Xsz);
M = reshape(M,Xsz);
if Dim ~= 1,
    S = ipermute(S,PER);
    M = ipermute(M,PER);
end

%% TEST:
function TEST

tmp = rand(1000,1);

tmp = zeros(1000,1); tmp(2:2:end) = 1;

figure
plot(tmp,'color',[1 1 1]/3);
hold
[s,m] = hmovvar(tmp,20);
plot(m,'b'); plot([s,m+sqrt(s)],'r');
