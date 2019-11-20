function R = hrankd(X,dim,DESC)
%HRANKD [**2ab++] Convert array to sort rank along one dim.
% Convert numerical array to integers representing sort rank along one dimension.
%
%          R = hrankd(X,dim,DESC)
% EXAMPLE: R = hrankd(rand(5,10),2) % ascending along dim=2
%          R = hrankd(rand(5,10),2,True) % ...descending
%
% NaNs are sorted to +Inf.
%
% SEE ALSO: TIEDRANK, hrank()

% AUTHOR: Hendrik Mandelkow, <2017
% TODO: NaNs result in missing rank numbers?!
% TODO: combine with hrank.m for dim = 0

if nargin>2 && ~~DESC, DESC = 'descend';
else DESC = 'ascend';
end
[~,R] = sort(X,dim,DESC);
[~,R] = sort(R,dim); % elegantly using indices as rank numbers
if any(isnan(X(:))),
	R(isnan(X)) = nan;
	warning('NaNs resulted in missing rank numbers.');
end
