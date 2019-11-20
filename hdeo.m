function [odat,x,BadEvt,dat] = hdatevtobs(dat, x, dx, dim)
%[**5a1++] Reshape data array dat by taking pieces of length dx along dim
% starting at indices in vect. x and stacking them in an extra dimension.
%
% [oDat,oX,BadEvt,tDat] = hdatevtobs(iDat, X, dX, Dim) : reshape data array dat by taking pieses of length dx along dim
% starting at indices in vect. x and stacking them in an extra dimension.
%
% SEE ALSO: hoed, hwindex

% PREC: hDatEvtObs 3B1.
% AUTHOR: Hendrik Mandelkow, 2000-07-04
% AUTH: HM, 4.7.00, v1b.
% AUTH: HM, 16.02.2004, ver. 1b1. Bugfix line 36.
% AUTH: HM, 22.06.2004, ver. 2B. Add NaN. Add Over.
% AUTH: HM, 22.06.2004, ver. 3B. Discard out of range events.
% AUTH: HM, 27.05.2005, ver. 3B1. Add dx1 : dx = [dx1,dx1+dx+1] range.
% AUTH: HM, 02.11.2005, ver. 4B. Change name and order of inputs.
% AUTH: HM, 06.2007, v.5B: Add output tDat (dat).
% AUTH: HM, 2012-02, v5A1: BUGFIX odat(:,BadEvt,:)= []; preserve dims.

if (nargin < 4) || isempty(dim),
    dim = 1;
end;
if (nargin < 3) || isempty(dx),
    dx = round(median(diff(x)));
elseif numel(dx) > 2
  error('Length(dx)>2, wrong order of inputs (dat,x,dx,dim)?');
end;

% If two boundaries given:
if any(rem(dx,1)), error('Range dx must be integer!'); end
if length(dx) > 1,
    dx1 = dx(1);
    x = x + dx1;
    dx = dx(2)-dx(1)+1;
else
    dx1 = 0;
end

%% Bad Evt
BadEvt = find((x < 1) | (x+dx-1 > size(dat,dim)));
if ~isempty(BadEvt),
    warning('hdatevtobs:bad','Will skip events out of data range: [%s]',...
        num2str(BadEvt(:).','%u '));
    x(BadEvt) = [];
end;

%% Shift Data
NoObsp = length(x);
ndim = ndims(dat);
dat = shiftdim(dat,dim-1);		% bring relevant dim to the front.
% NB: Leading singletons get lost in the back.
sz = size(dat);
sz = [dx, NoObsp, sz(2:end)];
% odat = NaN*zeros(sz,class(dat));
odat = nan(sz,class(dat));

%% +++
for ObspNo = 1:NoObsp,
    odat(:,ObspNo,:) = dat(x(ObspNo):x(ObspNo)+dx-1,:);
end

%% Reset x and dim
x = x - dx1;

if dim >1,
    % If less than ndim+1 dims, re-create trailing singletons:
    dd = ndim+1-ndims(odat);
    odat = shiftdim(odat,-dd);
    % odat = shiftdim(odat,dd+ndims(odat)-dim+1);
    odat = shiftdim(odat,dd+ndim-dim+1);
end

%% Return a signal truncated to the range of events.
% FIXIT Not tested!
if nargout > 3,
    dat(1:min(x(:))-1,:) = [];
    dat(max(x(:))+dx:end,:) = [];
end
