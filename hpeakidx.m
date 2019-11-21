function [Idx,Dat] = hpeakidx(Dat,Thr,varargin)
% [Idx,Dat] = hspiketimes(Dat,Thr,hFiltfiltArg)
% SEE: hMaxIdx, hFindMax
% AUTH: HM, 30.11.2003, ver. 1C.

if (nargin > 2) & ~isempty(varargin{1}) &(varargin{1} ~= 0),
    Dat = hfiltfilt(Dat,varargin{:});
else,
    %Dat = hfiltfilt(Dat,'butter',4,0.25,'high');
    Dat = hfiltfilt(Dat,'fir1',30,1/15,'high');
    % Distance between spikes min. 30 samples.
    % Spike width max. 15 samples.
end;
if nargin < 2,
    [SD,M] = hstd(Dat);
    Thr = M + 3.5 * SD;
end;

Dat(Dat < Thr) = 0;		% take pos threshold only
Dat = diff(Dat);			% differentiate
Dat = hzerox(Dat);			% find zero x-ings

Idx = find(Dat);
Idx = Idx - 1;      % zeroxing detects point AFTER xing i.e. after the peak.

return;
