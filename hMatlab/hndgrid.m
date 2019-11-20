function V = hndgrid(X)
% V = ndgrid(1:size(X,1),1:size(X,2),...)

% sz = size(X);
% for n=1:numel(sz), V{n} = (1:sz(n)); end
V = cellfun(@(x) (1:x), num2cell(size(X)),'Uniform',false);
[V{:}] = ndgrid(V{:});
