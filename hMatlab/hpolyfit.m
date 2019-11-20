function [p,S,mu,y,yd] = hpolyfit(x,y,np,d)
% hPOLYFIT[*1b+] Loop POLYFIT over array. Better use hPolyReg instead.
%
% SYNTAX:   [p,S,mu,yfit,delta] = hpolyfit(x,y,order,dim) % see POLYFIT + POLYVAL
%
% SEE: POLYFIT, hpolyreg()

% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2012-07-27, v1B.

sz = size(y);
if nargin < 4,
    d = find(sz>1,1);
end
if d~=1,
    y = hpermute(y,[1,d]);
end

if isempty(x),
    x = [1:size(y,1)].';
end
fprintf('\nhPolyFit...%9u',0);
for n = size(y(:,:),2):-1:1,
    [p(n,:),S(n),mu(n,:)] = polyfit(x(:),y(:,n),np);
    if nargout > 3,
        if nargout > 4,
            [y(:,n),yd(:,n)] = polyval(p(n,:),x,S(n),mu(n,:));
        else
            y(:,n) = polyval(p(n,:),x,[],mu(n,:));
        end
    end
    fprintf('\b\b\b\b\b\b\b\b\b%9u',n);
end
fprintf('\tDONE\n');
if nargout > 3
    y = reshape(y,sz);
    if exist('yd','var'), yd = reshape(yd,sz); end
    if d~=1,
        y = hpermute(y,[1,d]);
        if exist('yd','var'), yd = hpermute(yd,[1,d]); end
    end
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
