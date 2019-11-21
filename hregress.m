function [b,r,y,x] = hregress(x,y,d)
%[*1b+] Regress multivariate x from y
%
% SYNTAX:   [BETA,RESID,Yhat=X*B,X] = hpolyfit(X,Y,dim)
%
% B = X\Y
% Yh = X*B = X*(X\Y)
% Yr = Y - Yh = Y - X*(X\Y)
%
% SEE ALSO: hpolyreg (better!), hregress, hdetrend, DETREND, POLYFIT, POLYVAL
% AUTHOR: Hendrik Mandelkow, 2013

% AUTH: HM, 2013-05-22, v1B.

% sz = size(y);
if nargin < 4,
    d = find(size(y)>1,1);
end
% y = hpermute(y,[1 d]);
per = [d,1:d-1,d+1:ndims(y)];
y = permute(y,per);

% x = zscore(x,1,1);
% x(:,1) = 1;

% b = linsolve(x,y(:,:));
b = x\y(:,:);

sz = size(y);
b = reshape(b,[size(b,1),sz(2:end)]);
if nargout > 1,
    r = y(:,:) - x*b(:,:);
    r = reshape(r,size(y));
    if nargout > 2,
        % y = x*b;
        % y = reshape(y,size(r));
        y = y - r;
        %< y = hpermute(y,[1 d]);
        y = ipermute(y,per);
    end
    %< r = hpermute(r,[1 d]);
    r = ipermute(r,per);
end
