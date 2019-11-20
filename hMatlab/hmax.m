function [A,I] = hmax(A,D)
%[*1b] Max along multiple dimensions.
% for d=D(:).', [A,I] = max(A,[],d); end
for d=D(:).', [A,I] = max(A,[],d); end
