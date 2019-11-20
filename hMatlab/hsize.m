function sz = hsize(dat,varargin)
%hSize(dat, dim) [*3A1+] Same as SIZE but dim can be a vector
% e.g. sz = hsize(dat,[1:3],-2) % = sz([1:3,end-2])

% AUTHOR: Hendrik.Mandelkow@gamil.com, 2003
% AUTH: HM, 16.10.2003, ver.2A1.
% AUTH: HM, 2015, ver.3A1.

sz = size(dat);
if nargin > 1,
  dim = [varargin{:}];
  dim(dim<1) = dim(dim<1)+length(sz); % dim = [0,-1,-2] <=> end,end-1,end-2
  sz(end+1) = 1;
  dim = min(dim,length(sz)); % any dim>numdim(dat) = 1
  sz = sz(dim); % return only desired dims
end
