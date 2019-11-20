function C = hfront(h)
%hfront(Handles) [*3B+] Bring to front graphics objects.
%
% hfront = @(h) uistack(h,'top')
% hback = @(h) uistack(h,'bottom')
%
% SEE ALSO: UISTACK, hfront.old, hback.old

% AUTHOR: Hendrik Mandelkow, 2005, v3B

warning('Obsolete! Use uistack(h,''top'').')
uistack(h,'top');
if nargout
  C = get('children',get(h,'parent'));
end
