function x = hdetrend(x,d,varargin)
%[*1b+] Extend DETREND with dimension and polynomial parameters.
% Better to use HPOLYREG or HREGRESS
%
% SYNTAX:   y = hdetrend(x,...) same as DETREND(x,...)
%           y = hdetrend(x,dim,...) detrend along dimension dim.
%           y = hdetrend(...,'pol',p) detrend polynomial of order p.
%
% SEE ALSO: DETREND, POLYFIT, POLYVAL, hpolyreg (better!), hregress

% AUTHOR: Hendrik Mandelkow, 2003
% AUTH: HM, 15.09.2003, ver. 1B.
% AUTH: HM, 2012, ver. 2BC.

if ischar(d)
    varargin = [{d},varargin];
    d = 1;
end
x = hpermute(x,[1,d]);
xs = size(x);

if nargin>2 && strncmpi(varargin{1},'pol',3)
    n = [1:size(x,1)]';
    [p,~,mu] = polyfit(n,x,varargin{2});
    x = x - polyval(p,n,[],mu);
else
    x = detrend(x(:,:),varargin{:});
end
x = reshape(x,xs);
x = hpermute(x,[1,d]);

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
