function C = jetpair(N,X,F)
%hcm.jetpair(N,X) Colormap jet + alternating brightness for better
%distinction of lines.
%
% cmap = @(N) reshape([jet(N/2)'*0.7;jet(N/2)'*1],3,[])';

% AUTHOR: Hendrik Mandelkow, 2017-03-06, v1b: Happy Bday Dita.

if nargin<1, N = length(colormap); end
if nargin<2, X = 1:N; end
if nargin<3, F = 0.7; end
N = ceil(N/2);
% C = reshape([jet(N)'*F;jet(N)'*1],3,[])';
C = jet(2*N);
C(2:2:end,:) = C(1:2:end,:).*F;
C = C(X,:);
