function RGB = hbluered(N)
% Colormap

% AUTH: HM, 2012-10-08

if nargin < 1,
  N = length(colormap);
end

R = [0:N-1].'./(N-1);
G = zeros(size(R));
B = R(end:-1:1,1);

RGB = [R,G,B];
