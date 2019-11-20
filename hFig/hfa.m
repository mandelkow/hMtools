function H = hfa(H,N)
%[**1A2++] Find (all) axes (in current figure).
% Axes = hfa([Parents],[Number])
%
% hfa = @(H) findobj(H,'type','axes','-not','tag','Colorbar');
%
% SEE ALSO: FINDOBJ, hff, hfa

% AUTHOR: Hendrik Mandelkow, <2017, v1A2

if nargin < 1,
    H = gcf;
end
H = findobj(H,'type','axes','-not','tag','Colorbar');
if nargin > 1,
    H = H(N);
end
H = H(:).';
