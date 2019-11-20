function [X,R] = hrank(X,DESCEND)
%HRANK [**1a++] Convert array to sort rank of values.
% Ascending: Y = hrank(X) = hrank(X,false)
% Descending: Y = hrank(X,true) = hrank(-X)
%
% SEE ALSO: TIEDRANK, hrankd()

% AUTHOR: Hendrik Mandelkow, <2017

if nargin>1 && logical(DESCEND)
	[~,R] = sort(X(:),'descend');
else
	[~,R] = sort(X(:));
end
R(isnan(X(R))) = [];
X(:) = nan; % X(:) = 0;
X(R) = 1:numel(R);
