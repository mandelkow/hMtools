function y = hcmapinterp(N,Y,X)
%[1a] Obsolete. See HCMAPINT
% Colormap of N steps interpolated between colors Y(n,1:3) spaced at X(1:n).
% y = hcmapinterp(N,Y,X) = interp1(X(1:n),Y(1:n,1:3),[0:N-1]/(N-1))

% AUTHOR: Hendrik Mandelkow, 2014-12-12

if nargin < 1 || isempty(N),
  N = length(colormap);
end;
if nargin < 2,
    Y(1,:) = [0 0 1];   % [R,G,B]
    Y(2,:) = [0 1 0];
    Y(3,:) = [1 0 0];
elseif ischar(Y)
	L = 'RGBKWYCM';
	C = [1 0 0; 0 1 0; 0 0 1; 0 0 0; 1 1 1; 1 1 0; 0 1 1; 1 0 1];
	Y = bsxfun(@eq,L(:),Y(:)');
	Y = (1:numel(L)) * Y;
	Y = C(Y,:);
end
if nargin < 3,
    X = size(Y,1);
    X = [0:X-1].'./(X-1);
else
    X = X-min(X);
    X = X./max(X);
end
x = [0:N-1]/(N-1);
y = interp1(X,Y,x,'linear');

if nargout<1, colormap(y); end
