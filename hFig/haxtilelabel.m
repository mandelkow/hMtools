function [H,P] = haxtilelabel(Ax,NR,NC,Lab,Pos,varargin)
%HAXTILELABEL *1AB+ function [H,P] = haxtilelabel(Ax,NR,NC,Lab,Pos,varargin)
% SEE ALSO htextile()

% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2004, ver. 1ab

if nargin < 5 | isempty(Pos),
    %Pos = [0.01,0.01];
    Pos = [0.01,0.95];
end;
if (nargin<4) | isempty(Lab),
    Lab = cellstr(num2str([1:NR*NC]'));
end;
if isempty(NR),
    NR = size(Lab,1);
end;
if isempty(NC),
    NR = size(Lab,2);
end;
if isnumeric(Lab),
    Lab = cellstr(num2str(Lab(:)));
elseif ischar(Lab),
    Lab = cellstr(Lab);
end;

Pos(2) = 1-Pos(2);

for n=1:min(length(Lab(:)),NC*NR),
    [x,y] = ind2sub([NC,NR],n);
    x = (Pos(1)+ x-1)/NC;
    y = (Pos(2)+ y-1)/NR;
    y = 1-y;
    h = text(x,y,Lab{n},'unit','normal','tag','haxtilelabel');
    %set(h,'color','k','backgroundcolor','w');
    %set(h,'color','k','backgroundcolor','none');
    set(h,'fontsize',8);
    %set(h,'fontsize',8,'VerticalAlignment','bottom','horizontal','left');
    %set(h,'units','points');
    %set(h,'pos',get(h,'pos')+[2 0 0]);
    set(h,'units','data');
    H(n) = h;
    P(n,:) = [x,y];
end;

if nargin > 5,
    set(H,varargin{:});
end;

return;

%%% TEST:
tmp = [1:9]'*ones(1,9)
tmp = reshape(tmp',3,3,3,3)
himgtile(tmp,[],1)

[y,x] = meshgrid([0:10],[0:10])
tmp = sqrt(x.^2+y.^2)
tmp = repmat(tmp,[1,1,3,2]);
himgtile(tmp)
