function [nMI,MI] = hnmi(x, y)
% Compute nomalized mutual information I(x,y)/sqrt(H(x)*H(y)).

% AUTHOR: Michael Chen (sth4nth@gmail.com).
% AUTH: HM, 20??, v?: Made some changes.

assert(numel(x) == numel(y));
% HM! This function expects discrete data:
if any(rem(x(:),1)) || any(rem(y(:),1)),
    error('Expecting discrete data.');
end
n = numel(x);
x = x(:).'; % HM! x = reshape(x,1,n);
y = y(:).'; % y = reshape(y,1,n);

% Since x y are integers and we use sparse below, an independent rescaling of
% ranges is not necessary to conserve memory.
%< l = min(min(x),min(y));
l = min([x(:);y(:)]);
x = x-l+1;
y = y-l+1;
%< k = max(max(x),max(y));
k = max([x(:);y(:)]);

%< idx = 1:n;
% HM! = sparse(row,col,value,NofRows,NofCols,MaxNofElts)
Mx = sparse(1:n,x,1,n,k,n); % Mnk(n(i),x(i)) = 1;
My = sparse(1:n,y,1,n,k,n);
% My = sparse(1:n,y,true,n,k,n); % HM! Would this work (better)?

% Px = mean(Mx,1); % Histogram(x) (probability)
% Py = mean(My,1); % Histogram(y)
Px = nonzeros(mean(Mx,1)); % Histogram(x) (probability)
Py = nonzeros(mean(My,1)); % Histogram(y)
Pxy = nonzeros(Mx'*My)/n; % k*k joint distribution of x and y...
% reduced to non-zero bins. Pxy(n,m) = frequency of coorurrence for n and m

% entropy of Py and Px: Hx = -sum(Px.*log2(Px))
%Hx = -dot(Px,log2(Px+eps)); % eps ensures 0*log2(0) = 0,...
Hx = -dot(Px,log2(Px)); % ..., but so does nonzeros above.
Hy = -dot(Py,log2(Py));
Hxy = -dot(Pxy,log2(Pxy));

% mutual information
MI = Hx + Hy - Hxy;

% normalized mutual information
%< nMI = sqrt((MI/Hx)*(MI/Hy)) ;
nMI = MI./sqrt(Hx*Hy) ;
