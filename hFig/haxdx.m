function haxdx(h,dx)
%[**1b+] Add/change Xdata to line objects in axes.
% haxdx(h,dx)
% SEE ALSO: hxdata

% PREC: hXdata
% AUTHOR: Hendrik Mandelkow, 2000, v1B


if ~ishandle(h),
    dx = h;
    h = gca;
end
if length(dx) < 2,
    dx = [0,dx(1)];
end
% Add other object types...
h = findobj(h, 'type','line');

x = get(h(1),'xdata');
x = [0:length(x)-1]*dx(2)+dx(1);
set(h,'xdata',x);
