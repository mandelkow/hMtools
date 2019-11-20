function idx = hwindex(N,NW,DW,dim)
%HWINDEX [**2ab+++] Reshape data splitting one dim into (overlaping) windows.
%
% idx = hwindex(N,NW,DW) e.g. idx = hwindex(size(X,1),10,5)
% Y = hwindex(X,NW,DW) = reshape(X(idx,:),NW,[],size(X,2),size(X,3),...)
% Y = hwindex(X,NW,DW,dim) % other dim
%
% N = size of dim e.g. size(X,1)
% NW = window length or window shape to be applied to reshaped X
% DW = window step size or NOVERLAP if DW <= 0
% X = data to be reshaped in dim 1
%
% SIMPLE ALTERNATIVE:
% hwind = @(N,NW,DW) bsxfun(@plus,int32([0:NW-1].'),int32([1:DW:N-NW+1])); % +++
% sz = size(X);
% idx = hwind(sz(2),10,5);
% X = reshape(X(:,idx,:),[sz(1),size(idx),sz(3:end)])
%
% SEE ALSO: hdatwin.m

%% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2014-10, v1a
% AUTH: HM, 2018-07, v1a1: Non-essential bugfix.

if nargin>3, nd = ndims(N); N = shiftdim(N,dim-1); end
if numel(NW)>1
	WIN = NW(:);
	NW = length(WIN);
else
	WIN = [];
end
if nargin<3 || isempty(DW),
	DW = NW;
elseif DW <= 0, % DW = NOVERLAP
	DW = NW+DW;
end
if any([NW,DW]<1), error('NW & DW should be >= 1!?'); end
if numel(N)>1,
	X = N;
	N = size(X,1);
	sz = num2cell(size(X));
	if DW==NW
		X = reshape(X(1:end-rem(end,NW),:),NW,[],sz{2:end}); % +++
		if ~isempty(WIN)
			X = bsxfun(@times,X,WIN);
		end
		idx = X; clear X
		if nargin>3,
			nd = ndims(idx)-nd-1;
			idx = shiftdim(idx,nd); % compensate lost singletons
			idx = shiftdim(idx,ndims(idx)-dim+1-nd);
		end
		return;
	end
else
	X = [];
end
idx = bsxfun(@plus,int32([0:NW-1].'),int32([1:DW:N-NW+1])); % +++
idx(:,idx(end,:)>N) = []; % just to be safe
if ~isempty(X),
	X = reshape(X(idx,:),NW,[],sz{2:end});
	if ~isempty(WIN)
		X = bsxfun(@times,X,WIN);
	end
	idx = X;
end
if nargin>3,
	nd = ndims(idx)-nd-1;
	idx = shiftdim(idx,nd); % compensate for lost singletons
	idx = shiftdim(idx,ndims(idx)-dim+1-nd);
end
