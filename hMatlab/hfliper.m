function X = hfliper(X,dim)
%HFLIPER [***2B] Change orientation of data array. Permute and flip dims.
% for negative indices.
%
% SEE ALSO: hDatOri, hfilpdim

% AUTHOR: Hendrik Mandelkow

dim = dim(:).'; % just in case
% dim = [dim,numel(dim)+1:ndims(X)];
dim = [dim,setdiff(1:ndims(X),abs(dim))];
X = permute(X,abs(dim));
X = hflipdim(X,find(dim<0));

function x = hflipdim(x,dim)
% hDimInvert **1A: Invert array dimensions e.g. A = A(:,:,end:-1:1).
% FLIPDIM for several dimensions.
%
% SYNTAX: A = hdiminvert(A,[2,3])
%
%   Invert 2nd and 3rd dimension of array A.
%   Equivalent to A = A(:,end:-1:1,end:-1:1,:,...)
%
% SEE: FLIPDIM
%
% AUTH: HM, 12.10.2003, ver. 1A.

if 0
    nd = ndims(x);
    dim(dim > nd) = [];
    s = repmat({':,'},[1,nd]);
    for d = dim(:).'
        s(d) = {'end:-1:1,'};
    end
    s = [s{:}]; s(end) = '';
    eval(['x = x(',s,');']);
else
    v(1:ndims(x)) = {':'};
    for d = dim(:).'
        v{d} = size(x,d):-1:1;
    end
    x = x(v{:});
end
