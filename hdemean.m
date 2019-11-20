function X = hdemean(X,d)
% [*1a1++] Subtract (nan)mean along one dim.
%
% hdemean(X) = X - nanmean(X) = bsxfun(@minus,X,nanmean(X));
% hdemean(X,d) = X - nanmean(X,d) = bsxfun(@minus,X,nanmean(X,d));
% hdemean(X,0) = X - nanmean(X(:)) = bsxfun(@minus,X,nanmean(X(:)));
% 
% Equivalent anon. functions:
% hdemean = @(X,d) X - mean(X,d); % modern Matlab with broadcasting
% hdemean = @(X,d) bsxfun(@minus,X,mean(X,d)); % valid for all Matlab

% AUTHOR: Hendrik Mandelkow, <2016

if any(isnan(X(:))), warning('Input contains NaNs!'); end
if nargin<2
  X = bsxfun( @minus, X, nanmean(X));
elseif d==0
  X = X - nanmean( X(:) );
else
  X = bsxfun( @minus, X, nanmean(X,d));
end
