function C = hback(h)
%HBACK(Handles) [3B+] Send to back graphics objects. [= uistack(h,'bottom')]
%
% hfront = @(h) uistack(h,'top')
% hback = @(h) uistack(h,'bottom')
%
% SEE ALSO: UISTACK

% PREC: hfront.old, hback.old
% AUTHOR: Hendrik Mandelkow, 2005, v3B

warning('Obsolete! Use uistack(h,''bottom'').')
uistack(h,'bottom');
if nargout
  C = get('children',get(h,'parent'));
end
