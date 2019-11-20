function cmap = hhsv(m)
% [***1a] 6 HSV line colors reordered: dark blue,green,red,teal,yellow,magenta
% set(0,'DefaultAxesColorOrder',hhsvlines6());
% cmap = flipud(circshift(hsv(6),1))/2;
% cmap = hsv2rgb(mod([360-120:-360/m:1-120]',360)/360.*[1 0 0]+[0 1 .5]);
% cmap = cmap([1:2:end,2:2:end],:);

if nargin < 1, m = 6; end

% cmap = flipud(circshift(hsv(6),1))/2;
cmap = hsv2rgb(mod([360-120:-360/m:1-120]',360)/360.*[1 0 0]+[0 1 .5]);
cmap = cmap([1:2:end,2:2:end],:);
