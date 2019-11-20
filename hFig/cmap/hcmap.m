function cmap = hcmap(MapFun,m,n)
%[**2b] Get individual entries from any color map.
% cmap = hcmap(MapFun,MapLength,MapIndices)
%
% MapFun: CBRY, BWR, BR, BCYR, KBWRK, Hot, Cold, ColdHot
%
% BR = @(N) interp1([1 N],[0 0 1;1 0 0],1:N);
% BCYR = @(N) interp1([1,floor(N/2),ceil(N/2)+1,N],[0 0 1;0 1 1;1 1 0;1 0 0],1:N);

% AUTH: HM, 2005, v.1a
% AUTH: HM, 2014, v.2b


if nargin < 2,
	m = length(colormap);
end;
if size(m,1) > 1,
	m = size(m,1);
end
cmap = feval(MapFun,m);
if nargin > 2,
	if any(n(:)<1), n = max(1,ceil(n.*size(cmap,1))); end
	cmap = cmap(n,:);
end;

if nargout<1, colormap(cmap); end

end

%%
function cmap = CBRY(Nx)
%:**1a: Colormap green-blue-red-yellow cmap = hcmap_gbry(Nx)
% cmap = interp1([0 1 1; 0 0 .5; .5 0 0; 1 1 0],[1:1/28:1.99,2:1/8:2.99,3:1/28:3.99]);

if nargin < 1, Nx = size(colormap,1); end
Y = [0 1 1; 0 0 .5; .5 0 0; 1 1 0];
% X = [1,[7/16 9/16 1].*Nx];
% X = [0 7/16 9/16 1].*(Nx-1)+1;
Nx = Nx-1;
X = [0 7/16 9/16 1].*Nx;
x = (0:Nx);
cmap = interp1(X,Y,x);

% if nargout < 1, colormap(cmap); end
end

%%
function y = BWR(N)

if nargin < 1,
  N = length(colormap);
end;

X      = [0 1 2 3 4 5 6]/6;
Y(1,:) = [0 0 1 2 2 2 1]/2;    % RED
Y(2,:) = [0 0 1 2 1 0 0]/2;    % GREEN
Y(3,:) = [1 2 2 2 1 0 0]/2;    % BLUE

x = [0:N-1]/(N-1);
y = interp1(X',Y',x','linear');

% hclimsym;
end

%%
function y = BR(N)
y = interp1([1 N],[0 0 1;1 0 0],1:N);
end

%%
function y = BCYR(N)
y = interp1([1,floor(N/2),ceil(N/2)+1,N],[0 0 1;0 1 1;1 1 0;1 0 0],1:N);
end

%%
function y = KBWRK(N)

if nargin < 1,
  N = length(colormap);
end;

X      = [0 1 2 3 4 5 6 7 8]/8;
Y(1,:) = [0 0 0 1 2 2 2 1 0]/2;    % RED
Y(2,:) = [0 0 0 1 2 1 0 0 0]/2;    % GREEN
Y(3,:) = [0 1 2 2 2 1 0 0 0]/2;    % BLUE

x = [0:N-1]/(N-1);
y = interp1(X',Y',x','linear');

% hclimsym;
end

%%
function y = Hot(N)

if nargin < 1, N = length(colormap); end;

X      = [0 1 2 3]/3;
Y(1,:) = [0 1 1 1]/1;    % RED
Y(2,:) = [0 0 1 1]/1;    % GREEN
Y(3,:) = [0 0 0 1]/1;    % BLUE

x = [0:N-1]/(N-1);
y = interp1(X',Y',x','linear');

end
%%
function y = Cold(N)

if nargin < 1, N = length(colormap); end;

X      = [0 1 2 3]/3;
Y(1,:) = [0 0 0 1]/1;    % RED
Y(2,:) = [0 0 1 1]/1;    % GREEN
Y(3,:) = [0 1 1 1]/1;    % BLUE

x = [0:N-1]/(N-1);
y = interp1(X',Y',x','linear');

end

%%
function y = ColdHot(N)

if nargin < 1, N = length(colormap); end;

% X      = [0 1 2.3 3 3.7 5 6]/6;
X      = [0 1 2 3 4 5 6]/6;
Y(1,:) = [0 0 0 1 1 1 0]/1;    % RED
% Y(2,:) = [0 0 1 1 1 0 0]/1;    % GREEN
Y(2,:) = [0 0 .9 1 .9 0 0]/1;    % GREEN
Y(3,:) = [0 1 1 1 0 0 0]/1;    % BLUE

x = [0:N-1]/(N-1);
y = interp1(X',Y',x','linear');

end
