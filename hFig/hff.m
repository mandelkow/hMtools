function H = hff(H,N)
%[**1A3++] Find (all) figures. Sort by number.
% Fig = hff;
% Fig = hff([Handles],[Number])
%
% hfa = @(H) findobj(H,'type','axes','-not','tag','Colorbar');
% hff = @(H) findobj(H,'type','figure');
%
% SEE ALSO: FINDOBJ, hff, hfa

% AUTHOR: Hendrik Mandelkow, <2017, v1A3

if nargin < 1,
    H = 0;
end
H = findobj(H,'type','figure');
if isempty(H), return; end
[~,n] = sort([H.Number]);
H = H(n);
if nargin > 1,
    H = H(N);
end
