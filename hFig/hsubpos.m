function P = hsubpos(R,C,r,c)
% hSubPos *1B: Position vector for OuterPosition of subplot.
%
% e.g. hsubpos(3,2,2,2) = subplot(3,2,4)
% e.g. hsubpos(3,2,[1,2],1) = subplot(3,2,[1,3])
%
% SEE: hsp.m

% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 11.2007, ver. *1B

if nargin < 4,
    if any(r>C*R), error('Index exceeds table dimensions.'); end
    [c,r] = ind2sub([C,R],r);
end

c = [min(c)-1,max(c)-min(c)+1];
r = [R-max(r),max(r)-min(r)+1];
P = [c(1)/C r(1)/R c(2)/C r(2)/R];
