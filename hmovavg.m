function X = hmovavg(X, N, Dim, Meth)
%[**3AB+] Moving average filter of 2*N+1 points (symmetric).
%
% SYNTAX: Y = hMovAvg( X, N, Dim, Meth)
%
% Meth = 1 : Use FILTER with constant (mean) starting/ending conditions.
% Meth = 2 : (Default) Use FILTER with mirrored starting/ending conditions.
% Meth = 3 : Use FILTFILT with filter order N+1.
%
% SEE ALSO: hMvAvg.m

%% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 07.02.2006, ver. 2A.
% AUTH: HM, 2012-02, v.3AB

%hmvavg= inline('filter(ones(M,1), [1], X, [], Dim)', 'X','M','Dim')

if nargin < 4,
    Meth = 2;
end;
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

if N<0,
    N = round((abs(N)-1)/2);
end
M = 2*N+1;
switch Meth,
    case 0,
        X = filter(ones(1,N)./N,1,X);
    case 1,
        X = [ones(N,1)*mean(X(2:N+1,:),1); X; ones(N,1)*mean(X(end-N:end-1,:),1)];
        X = filter(ones(1,M)./M, [1], X, [], 1);
        X = X(M:end,:);
    case 2,
        % %%% HOWTO do elegant moving average by filtering:
        B = ones(1,M)./M;
        X = [(X(N+1:-1:2,:) + ones(N,1)*X(1,:))/2; X];
        X = [X; (X(end-1:-1:end-N,:) + ones(N,1)*X(end,:))/2];
        X = filter(B,1,X);
        X = X(M:end,:);
    case 3,
        warning('This is almost certainly WRONG.');
        % NB: FILTFILT produces twice the filter order and zero phase
        % distortions.
        % M = round(M/2);
        M = N+1;
        X = filtfilt(ones(M,1)/M,[1],X);
    otherwise,
        error
end

X = reshape(X,Xsz);
if Dim ~= 1,
    X = ipermute(X,PER);
end

%% TEST:
function TEST

tmp = rand(1,1000);
figure
plot(tmp,'color',[1 1 1]/3);
hold
plot(hmovavg(tmp,10,[],1),'b')
plot(hmovavg(tmp,10,[],2),'g')
plot(hmovavg(tmp,10,[],3),'m')
