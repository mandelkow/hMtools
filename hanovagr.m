function [F,DFF,CNR,P,DF] = hanovagr(F,G,R)
%[***3ab++] Multiple ANOVA1 on MD array with size(X,G) groups and size(X,R) repetitions.
% hAnovaGR = @(X,G,R) var(mean(X,R),1,G)./mean(var(X,1,R),G).*(size(X,G).*(size(X,R)-1)./(size(X,G)-1));
% G, R = dimension of groups and repetitions (samples per group)
%
% F(...) = hanova(X(...,t,n)) = hanova(X(...,groups,repetitions))
% hFinvGR = @(p,g,r) finv(p,g-1,g*(r-1));
%
% hCNR2 = @(X,G,R) var(mean(X,R),1,G)./mean(var(X,1,R),G); % CNR^2
% hDFfac = @(g,r) g*(r-1)/(g-1); % degree of freedom factor ANOVA = DF*CNR^2
%
% hVarFrac = @(X) var(mean(X(:,:),2),1) ./ var(X(:),1)
% TEST: Vf = hVarFrac(repmat(rand(128,1),1,8)) % = 1 % OK!
% hVarFracGR = @(X,G,R) var(mean(X,R),1,G)*size(X,G)*size(X,R)./var(X(:),1)/numel(X)
% hVarFracGR = @(X,G,R) var(mean(X,R),1,G)./var(X(:),1).*(size(X,G)*size(X,R)/numel(X))
% TEST: Vf = sum(hVarFracGR(repmat(rand(128,1),1,16,10),1,2)) % = 1 % OK?!?
%
% NOTES:
% Total var: SST = sum((X(:)-mean(X(:))).^2) = numel(X)*var(X(:),1)
% Residual var: SSE = sum((X-mean(X,2)).^2,1)
% Model var: SSB = sum(size(X,2)*(mean(X,2)-mean(X(:))).^2) = numel(X)*var(mean(X,2),1)
% Var.fraction explained: Vfrac = SSB / SST = var(mean(X,2),1) / var(X(:),1)
%
% SEE ALSO: hanova3d

%% TODO:
% * renamed this to hanovagrnan.
% * remove nans here or make DONAN a trailing parameter
%
%% AUTHOR: Hendrik Mandelkow, 2014
% AUTH: HM, 2014-08, v1a
% AUTH: HM, 2015-01, v2ab. Add hAnovaGR, G and R
% AUTH: HM, 2017-03, v3ab. Deal with NaN
% AUTH: HM, 2017-03, v3ab1. Add P and DF

% N = size(img,5); T = size(img,4);
% cimg = mean(img,5);
% SSE = sum(bsxfun(@minus,img,cimg).^2,4);
% SSE = T*sum(var(img,1,4),5);
% SSE = N*T*mean(var(img,1,4),5);
% SSB = N*T*var(mean(img,5),1,4);
% cimg = N*T*var(cimg,1,4);
% cimg = sum(N.*bsxfun(@minus,cimg,mean(img(:,:,:,:),4)).^2,4); % <=>
% cimg = sum(N.*bsxfun(@minus,cimg,mean(cimg,4)).^2,4); % <=>
% cimg = N*T*var(cimg,1,4); % = N*T*var(mean(img,5),1,4) <=>
% cimg = SSB./SSE ./ (T-1) * T*(N-1);

% sz = size(X);
% R = length(sz); % dim. of repetitions / samples (per group)
% G = R-1; % group dimension
% NR = sz(end); % nr of repetitions
% NG = sz(end-1); % nr of groups
% X = var(mean(X,R),1,G)./mean(var(X,1,G),R)*NG*(NR-1)/(NG-1); % *** OK

%% TEST
%{
tmp = randn(10,5);
[~,a] = anova1(tmp,[],'off')
[f,~,~,p] = hanovagr(tmp.')
%}

if nargin<3, R = ndims(F); end
if nargin<2, G = R-1; end

nn = isnan(F);
if any(nn(:)),
	warning('NaNs will be ignored!');
	nn = sum(all(nn,R),G); % may result in variable nn
	nn = max(nn(:)); % ...could omit to accept variable DF.
	if any(nn(:))>0, warning('Degrees of freedom adjusted by -%u',nn); end
else
	nn = 0;
end
% DFF = size(F,G).*(size(F,R)-1)./(size(F,G)-1);
% if any([size(F,R),size(F,G)])==0, error('Degrees of freedom < 1!'); end
% DFF = (size(F,G)-nn).*(size(F,R)-1)./(size(F,G)-1-nn);
% if (DFF==0) || isinf(DFF), error('Degrees of freedom < 1!'); end
DF = [(size(F,G)-1-nn), (size(F,G)-nn).*(size(F,R)-1)];
DF(DF<1) = nan;
% if any(DF<1), error('Degrees of freedom < 1!'); end
DFF = DF(2)./DF(1);

% hAnovaGR = @(X,G,R) var(mean(X,R),1,G)./mean(var(X,1,R),G).*(size(X,G).*(size(X,R)-1)./(size(X,G)-1));
% F = var(mean(F,R),1,G)./mean(var(F,1,R),G).*(size(F,G).*(size(F,R)-1)./(size(F,G)-1));
% F = var(mean(F,R),1,G)./mean(var(F,1,R),G);
% F = var(nanmean(F,R),1,G)./mean(nanvar(F,1,R),G);
F = nanvar(nanmean(F,R),1,G)./nanmean(nanvar(F,1,R),G);
if nargout>2, CNR = sqrt(F); end
F = F.*DFF;
if nargout>3, P = fcdf(F,DF(1),DF(2),'upper'); end
