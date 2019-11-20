function Dat = hobsevtdat(Obs, Evt, Dat)
% odat = hObsEvtDat(Obs,Evt,Dat) - Replace pieces of vector Dat with columns of Obs at locations in Evt.
% INPUT:	Obs = double(T,N) : N vectors of length T.
%			Evt = vect (length N) of indices into vect. Dat.
%			Dat = Data vector to be modified.
% OUTPUT: odat = Output data vect of length(Dat).

%% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 20.7.00, v1b.
% AUTH: HM, 04.2006, v1b1.

% INCLUDE: none.

% disp('hObsEvtDat Version 1b, HM 20.7.00 : Overwrite certain pieces of a data vector.');

%%% CHECK INPUT:
if (nargin < 2),
   disp('help nObsEvtDat');
   help('nObsEvtDat');
   return;
end;

dx = size(Obs,1);

if (nargin < 3),
   Dat = zeros(Evt(end)+dx-1,1);
end;

if length(Evt) ~= size(Obs,2),
   warning('Evt and Obs don''t match in size - SOME SKIPPED!');
end;
%keyboard
%%% MAIN:
for EvtNo = 1:min(length(Evt),size(Obs,2)),
    if Evt(EvtNo) < 1 || (Evt(EvtNo)+dx-1) > length(Dat),
        warning('Event no. %u exceeds output dimension - SKIPPED!\n',EvtNo);
        if Evt(EvtNo)+dx-1 >= 1 || Evt(EvtNo) <= length(Dat),
            tmp = [1-Evt(EvtNo), Evt(EvtNo)+dx-1-length(Dat)];
            tmp(tmp<0) = 0;
            Dat( Evt(EvtNo)+tmp(1):Evt(EvtNo)+dx-1-tmp(2)) = Obs(tmp(1)+1:end-tmp(2),EvtNo);
        end
    else
        Dat( Evt(EvtNo):Evt(EvtNo)+dx-1) = Obs(:,EvtNo);
    end;
end;

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TESTING:
T = [0:100]';
Dat = sin(2*pi/10*T);
Obs = ones(10,2);
Evt = [10,50];

odat = nObsEvtDat(Obs, Evt, Dat);

figure;
plot(odat)
