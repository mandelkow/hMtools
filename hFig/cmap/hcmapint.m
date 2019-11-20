function y = hcmapint(N,Y,X)
%HCMAPINT [***2a1++] Create color map by interpolation.
%
% cmap = hcmapint(N,C,X)
% N = length of cmap(1:N,3)
% C = [1 0 0; 1 1 1; 0 0 1] or C = 'RWB' (colours)
% X(1:size(C,1)) interpolant steps (optional)
%
% TRY: figure; imagesc(1:64); hcmapint([],'KCBGRYW');

% PREC: HCMAPINTERP
% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2005, v.1a
% AUTH: HM, 2014-12, v.2a: Add Y = 'RGB'
% AUTH: HM, 2014-12, v.2a1: Add Y = '-'

% hcmapint([],[0 0 0; .7 .2 0; .2 .7 0; 1 1 0; 1 1 1; .7 .7 1]); % Africa

if nargin < 1 || isempty(N),
  N = length(colormap);
end;
if nargin < 2,
    Y(1,:) = [0 0 1];   % [R,G,B]
    Y(2,:) = [0 1 0];
    Y(3,:) = [1 0 0];
elseif ischar(Y)
	L = 'RGBKWYCM-rgbkw';
	C = [1 0 0; 0 1 0; 0 0 1; 0 0 0; 1 1 1; 1 1 0; 0 1 1; 1 0 1;...
		nan nan nan; .5 0 0; 0 .5 0; 0 0 .5; .3 .3 .3; .5 .5 .5];
	% Y = upper(Y);
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
X(any(isnan(Y),2)) = [];
Y(any(isnan(Y),2),:) = [];

x = [0:N-1]/(N-1);
y = interp1(X,Y,x,'linear');

if nargout<1, colormap(y); end
