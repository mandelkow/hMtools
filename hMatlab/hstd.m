function [s, m, r, z, se] = hstd(x, dim, flag)
%HSTD : Standard deviation (y), mean (xm) and centered input (xc).
% Accounts for complex input and twice the degrees of freedom respectively.
%
%USAGE: [s, m, r, z, se] = hstd(x,dim,flag)
%   s = STD, m = mean, r = residuals (x-m) = centered x
%   z = normalised residuals (x-m)/s = z-score
%   se = standard error of mean s/sqrt(N)
%
%STD    Standard deviation.
%   For vectors, STD(X) returns the standard deviation. For matrices,
%   STD(X) is a row vector containing the standard deviation of each
%   column.  For N-D arrays, STD(X) is the standard deviation of the
%   elements along the first non-singleton dimension of X.
%
%   STD(X) normalizes by (N-1) where N is the sequence length.  This
%   makes STD(X).^2 the best unbiased estimate of the variance if X
%   is a sample from a normal distribution.
%
%   STD(X,1) normalizes by N and produces the second moment of the
%   sample about its mean.  STD(X,0) is the same as STD(X).
%
%   STD(X,FLAG,DIM) takes the standard deviation along the dimension
%   DIM of X.  When FLAG=0 STD normalizes by (N-1), otherwise STD
%   normalizes by N.
%
%   Example: If X = [4 -2 1
%                    9  5 7]
%     then std(X,0,1) is [ 3.5355 4.9497 4.2426] and std(X,0,2) is [3.0
%                                                                   2.0]
%   See also COV, MEAN, MEDIAN, CORRCOEF.

%   J.N. Little 4-21-85
%   Revised 5-9-88 JNL, 3-11-94 BAJ, 5-26-95 dlc, 5-29-96 CMT.
%   Copyright (c) 1984-98 by The MathWorks, Inc.
%   $Revision: 5.17 $  $Date: 1997/11/21 23:24:08 $

% AUTH: HM, 13.10.00, Changed to output mean and centered data too.
% AUTH: HM, 14.02.05, Account for complex numbers and degrees of freedom.
% AUTH: HM, 24.03.05, Handle NaNs.
% AUTH: HM, 10.10.12, Use BSXFUN (w/o tile) and replace NaNs in xc.
% AUTH: HM, 01.11.12, Add output z. Rename output s,m,r,z.
% AUTH: HM, 2014-03, Add output se.

if nargin<3, flag = 0; end
if nargin<2,
  dim = find(size(x)~=1,1);
  if isempty(dim), dim = 1; end
end

% Avoid divide by zero.
if size(x,dim)==1,
    warning('hStd:Singleton','No variance in singleton dimension.');
    s = zeros(size(x));
    m = x; r = x; z = []; se = s;
    return
end

nanidx = isnan(x);
if any(nanidx(:)),
    warning('hStd:IgnoreNan','Ignore NaN values.');
    df = sum(~nanidx,dim);
else
    nanidx = [];
    df = size(x,dim);   % Degrees of freedom.
end;
x(nanidx) = 0;
m = sum(x,dim)./df;
r = bsxfun(@minus,x,m);  % Remove mean
% r(nanidx) = NaN;

if flag,
    df = df-1;
end
if ~isreal(x),
    df = 2*df;
end
s = sqrt(sum(conj(r).*r,dim)./df);
r(nanidx) = NaN;

if nargout > 3,
    z = bsxfun(@rdivide,r,s);
end
if nargout > 4,
    se = s./sqrt(df);
end

%% OLD:
% if flag,
%   y = sqrt(sum(conj(xc).*xc,dim)/size(x,dim));
% else
%   y = sqrt(sum(conj(xc).*xc,dim)/(size(x,dim)-1));
% end
