function [Nr,Nc] = himgbestrect(Sz,R)
%[3A] Find optimal tiling for images by minimizing the circumference.
%
% SYN:  [Nrow,Ncol] = himgbestrect(size(Img(:,:,:)))
%           Minimize circumference i.e. most compact.
%       [Nrow,Ncol] = hbestrect(size(Img(:,:,:)),[X,Y])
%           Maximize area given spatial dimensions X,Y in equal units.
%
% PREC: hBestRect()

% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 07.2006 v3a: Take given space into account.
% AUTH: HM, 06.2006 v2a: WAY simpler algorithm than before!
% AUTH: HM, 2004

Sz = Sz(:).';
switch length(Sz),
    case 0,
        error('Invalid SIZE parameter.');
    case 1,
        Sz = [1 1 Sz];
    case 2,
        Sz = [1 Sz];
    otherwise,
        Sz = [Sz(1:2),prod(Sz(3:end))];
end;

Nr = 1:Sz(3);
Nc = ceil(Sz(3)./Nr);
if nargin < 2,
    % Find minimal circumference:
    C = Nr*Sz(2) + Nc*Sz(1);
    [Nr,Nr] = min(C);
else
    % Find maximal area:
    C = min([R(1)./Sz(1)./Nc; R(2)./Sz(2)./Nr]);
    [Nr,Nr] = max(C);
end
Nc = ceil(Sz(3)./Nr);

if nargout < 2,
    Nr = [Nr,Nc];
end;
