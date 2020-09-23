function [b,r,y,x] = hpolyreg(x,y,np,d,POL)
% HPOLYREG [**2b1+] Polynomial fit and detrend along specified array dimension.
%
% SYNTAX:   [BETA,RESID,Yhat,X] = hpolyreg(x,y,order,dim,POL)
%    if POL : use Legendre polynomials
%
% SEE: hPOLYFIT, hPolyBase, POLYFIT, POLYVAL

%% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2012-08-07, v1B.
% AUTH: HM, 2013-10-26, v2B. Add NaN protection.

% sz = size(y);
if nargin < 4, d = find(size(y)>1,1); end
if nargin < 5, POL = false; end
% y = hpermute(y,[1 d]);
per = [d,1:d-1,d+1:ndims(y)];
y = permute(y,per);

if isempty(x),
	x = (0:size(y,1)-1).';
	x = x - x(end)/2; % Center x for better results?
end
nn = isnan(x(:));
if POL, % Use Legendre poly., see AFNI 3dDetrend.
	error('These are Legendre functions not *polynomials*!')
  % This is OK if x is already symmetric about 0:
	%< x = x(:)./max(abs(x(:))); % Legendre defined on -1:1
  % x = x - min(x(:)); x = x ./ max(x(:)); x = x.*2 - 1; % Legendre defined on -1:1
  x = (x - min(x(:)))./range(x(:)).*2 - 1; % Legendre defined on -1:1
	x = legendre(np,x(:),'norm').';
else % Use polynomials - DEFAULT
	x = bsxfun(@power,x(:),(0:np));
end
% x = zscore(x,1,1);
[~,~,~,x] = hstd(x,1,1); % zscore w/ nan
x(:,1) = 1;

% nn = isnan(y(:,:));
nn = bsxfun(@or,isnan(y(:,:)),nn);
if any(nn(:)),
	warning('hPolyReg:NaN','NaNs in X or Y ignored.')
	for n=[size(nn,2):-1:1],
		b(:,n) = x(~nn(:,n),:)\y(~nn(:,n),n);
	end
else
	% b = linsolve(x,y(:,:));
	b = x\y(:,:);
end
sz = size(y);
b = reshape(b,[np+1,sz(2:end)]);
if nargout > 1,
	%< r = y(:,:) - x*b(:,:);
	%< r = reshape(r,size(y));
	r = y(:,:); r = reshape(r,size(y));
	y = x*b(:,:); y = reshape(y,size(r));
	r = r-y;
	y = ipermute(y,per);
	r = ipermute(r,per);
end

%% TEST
% function TEST()
% x = [0:999]+100*randn(1,1000);
% plot(x)
% x = shiftdim(x,-3);
% size(x)
% % x = hdetrend(x,5,'constant');
% x = hdetrend(x,5,'linear');
% size(x)
% x = shiftdim(x,4);
% plot(x)
