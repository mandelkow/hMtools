function cmap = gray(N,A,B)
% Colormap

% AUTHOR: Hendrik Mandelkow, 2006-08-25

if nargin < 1 || isempty(N),
    N = size(colormap,1);
end
if nargin < 2,
    A = 0;
end
if nargin < 3,
    B = 1;
end
N = N-length(A)-length(B)+1;
cmap = repmat(A(end)+[0:N].'./N.*(B(1)-A(end)),[1,3]);
cmap = [A(1:end-1).'*ones(1,3);cmap];
cmap = [cmap;B(2:end).'*ones(1,3)];
