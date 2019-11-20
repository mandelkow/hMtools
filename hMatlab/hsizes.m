function sz = hsizes(varargin)
% sz(n,:) = size(varargin{n})

%% AUTHOR: Hendrik Mandelkow

for n=1:nargin,
  sz(n,1:ndims(varargin{n})) = size(varargin{n});
end
