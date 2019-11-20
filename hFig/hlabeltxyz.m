function h = hlabeltxyz(varargin)
% hLabelTXYZ = @(t,x,y,z) [title(t),xlabel(x),ylabel(y),zlabel(z)];
% function h = hlabeltxyz(T,X,Y,Z)
% h = [title(T),xlabel(X),ylabel(Y),zlabel(Z)];

% AUTHOR: Hendrik Mandelkow

varargin{5} = []; % assure it's long enough
h = [title(varargin{1}),xlabel(varargin{2}),ylabel(varargin{3}),zlabel(varargin{4})];
