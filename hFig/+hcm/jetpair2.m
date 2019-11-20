function C = jetpair2(N,X,F)
%hcm.jetpair2(N,X,F) Colormap jet + alternating brightness for better
%distinction of lines.
%
% C = jetpair2(N)
% C = jet(N);
% C(2:2:end,:) = C(2:2:end,:).*0.7;

% AUTH: Hendrik Mandelkow, 2017-03-06, v1b: Happy Bday Dita.

if nargin<1, N = length(colormap); end
if nargin<2, X = 1:N; end
if nargin<3, F = 0.7; end

C = jet(N);
C(2:2:end,:) = C(2:2:end,:).*F;
C = C(X,:);
