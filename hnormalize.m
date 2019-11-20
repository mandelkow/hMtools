function C = hnorm(C,d)
% hNormd = @(C,d) bsxfun(@rdivide,C,sqrt(sum(C.^2,d)));
% hNormd = @(C,d) C./sqrt(sum(C.^2,d));

%% AUTHOR: Hendrik Mandelkow

try
  if d==0
    C = C ./ sqrt(sum(C(:).^2));    
  else
    C = bsxfun(@rdivide,C,sqrt(sum(C.^2,d)));
  end
catch
  C = bsxfun(@rdivide,C,sqrt(sum(C.^2)));
end
