function hcloseallbut(X)
% hCloseAllBut - Close all figs except some.

F = findobj(0,'type','figure');
for n = 1:length(F(:)),
   idx = find(X == F(n));
   if idx,
      X(idx) = [];
   else,
      close(F(n));
   end;
end;

return;
