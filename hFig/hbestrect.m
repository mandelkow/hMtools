function [N1,N2] = hbestrect(N1N2,Rtol,R)
%HBESTRECT [**1A1] Divide integer N1N2 into two integer factors as evenly as possible.
% function [N1,N2] = hbestrect(N1N2,Rtol,R)
% N1N2 = int(1)
% N1 = int(1,2)
% prod(N1) >= N1N2
% R = N1/N2
% N1/N2 < Rtol
% N1 >= N2
%
% SEE: NEW hImgBestRect.m (takes into account image dimensions?!

% AUTHOR: Hendrik Mandelkow

if nargin < 3,
    R = 1;
elseif length(R)>1,
    R = R(1)/R(2);
end;
if nargin < 2,
    Rtol = [];
end;

N1N2 = prod(N1N2);
F = factor(N1N2);
N = length(F);

D = [1:2^N-1]';     % decimal
D = dec2bin(D);     % char
D = (D=='1');       % logical

F = repmat(F,size(D,1),1);
D = D .* F;         % double
D(D==0) = 1;
D = prod(D,2);
[F,F] = min(abs(D*R-sqrt(N1N2)));

N1 = D(F);
N2 = N1N2/N1;
if N1 < N2, % Enforce: N1 >= N2
    [N1,N2] = deal(N2,N1);
end;
if ~isempty(Rtol) && (N1/N2/R > Rtol),  % If the rectangle is too elongated.
    N1 = ceil(sqrt(N1N2));
    N2 = floor(sqrt(N1N2));
end;
if nargout < 2,
    N1 = [N1,N2];
end;
