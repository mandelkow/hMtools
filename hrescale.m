function [Dat,M,S] = hrescale(Dat, R, Dim)
%[*3B++] Rescale data array linearly.
%
% [Dat,Min,Scale] = hrescale(Data,Range,Dim)

% PREC: hDatRescale
%% AUTHOR: Hendrik Mandelkow, 2005
% AUTH: HM, 2005, v1B
% AUTH: HM, 2006, v1B1. Avoid divide by zero.
% AUTH: HM, 2008, v1B2. Avoid divide by zero & all zero.
% AUTH: HM, 2013, v3A. Add syntax R = 'uint8'

if nargin < 2 || isempty(R)
   R = [0 1];
elseif ischar(R) % given type eg 'uint8'
    Cla = lower(R);
    R = double([intmin(Cla), intmax(Cla)]);
end
if nargin < 3 % Apply same scaling to whole array.
    Dim = 0;
end

% Ignore Inf values in rescaling operation:
if ~isfloat(Dat)
    warning('Integer data type - recast to DOUBLE.');
    Dat = double(Dat);
end
infidx = find(isinf(Dat));
infsig = Dat(infidx)<0;
Dat(infidx) = NaN;

if Dim % Scale each (column) separately along Dim.
    [Dat,Dp,Ds] = shiftdata(Dat,Dim);
    % old: Dat = Dat - hrepmat(min(Dat,[],1),size(Dat));
    M = min(Dat,[],1);
    Dat = bsxfun(@minus,Dat,M);
    S = max(Dat,[],1);
    S(~S) = 1;
    % old: Dat(:,:) = Dat(:,:) .* repmat(diff(R(1:2))./S,[size(Dat,1),1]);
    S = (R(2)-R(1))./S;
    Dat(:,:) = bsxfun(@times,Dat(:,:),S);
    Dat = Dat + R(1);
    Dat = unshiftdata(Dat,Dp,Ds);
else % Apply same scaling to whole array.
    M = min(Dat(:));
    Dat = Dat - M;
    S = max(Dat(:));
    S(~S)=1; % Avoid divide by zero!
    Dat = Dat.*(diff(R(1:2))./S);
    Dat = Dat + R(1);
end

Dat(infidx) = Inf;
Dat(infidx(infsig)) = -Inf;

if exist('Cla','var'), Dat = cast(Dat,Cla); end
