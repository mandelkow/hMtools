function P = hpickpeak(Y,Fs,P)
%hPickPeak [1b] (De-)Select points (peaks) on a line plot.
%
% PeakIdnices = hpickpeak(Signal, SamplingRate, PeakIndices)

% AUTHOR: Hendrik Mandelkow, 2017-03-02, v1b

% plot(10:20,'o','ButtonDownFcn',@(a,b) disp(b)) % TEST

hPeaks = @(Y) find(diff(diff(Y)<0)>0)+1;

if nargin<1
	Fs = 10;
	X = (0:1/Fs:10);
	Y = sin(3*X/Fs*2*pi);
	% P = Fs:Fs:numel(Y);
end
if nargin<2, Fs = 1; end
if nargin<3, P = hPeaks(Y); end
if islogical(P), P = find(P); end

X = (0:numel(Y)-1)/Fs;

figure('name','hPickPeak');
Hy = plot(X,Y,'r.-','markersize',10,'tag','P');
hold on;
Hp = plot(X(P),Y(P),'go','markersize',5,'tag','Y','markerfacecolor','g');
Hy.ButtonDownFcn = {@hBDfunY,Hp};
Hp.ButtonDownFcn = @hBDfunP;
title('\rm\it (De-)select points - hit key when done.');

pause;

P = 1+Hp.XData*Fs;

set([Hy,Hp],'ButtonDownFcn',[]);

function hBDfunP(A,B)
if B.Button~=1, return; end
x = B.IntersectionPoint(1);
[~,x] = min(abs(x-A.XData));
A.XData(x) = [];
A.YData(x) = [];

function hBDfunY(A,B,H)
if B.Button~=1, return; end
x = B.IntersectionPoint(1);
[~,x] = min(abs(x-A.XData));
H.XData(end+1) = A.XData(x);
H.YData(end+1) = A.YData(x);
[H.XData,x] = sort(H.XData);
H.YData = H.YData(x);
