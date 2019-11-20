function [S,Idx] = hzerox(S,Dim)
%HZEROX [*3a+] Find zero crossings in a (time-series) vector.
% Mark the data point AFTER the x-ing such that find(hzerox(diff(X))) marks the 
% peaks in X.

% AUTHOR: Hendrik Mandelkow
% AUTH: HM 27.10.00, ver.1A.
% AUTH: HM 30.11.2003, ver.2AB. New parameter Dim. SD has same size as S.
% AUTH: HM 2018-06, v3a. Streamlined.

if nargin < 2, Dim = []; end
[S,P,N] = shiftdata(S,Dim);

S = diff(sign(S([1,1:end],:)))./2;
S(abs(S)<1) = 0;

S = unshiftdata(S,P,N);
if nargout > 1, Idx = find(S); end
