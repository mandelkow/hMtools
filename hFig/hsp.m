function [H,Pos] = hsp(varargin)
%[**4A2] SUBPLOT based on "OuterPosition" property.
%
% [AxHdl,AxPos] = hsubplot([AxHdl,] NofRows, NofCols, RCidx)
% [AxHdl,AxPos] = hsubplot([AxHdl,] NofRows, NofCols, -RCidx)
% [AxHdl,AxPos] = hsubplot([AxHdl,] NofRows, NofCols, Ridx, Cidx)
% [AxHdl,AxPos] = hsubplot(...,Margin,Spacing[Col,Row],Padding=LooseInset)
%
%		Margin - around the perimeter of the figure
%		Spacing - between columns/rows of axes
%		Padding = OuterPos - (Position + TightInsert)
%
% e.g. hsubplot(3,2,2,1) = hsubplot(3,2,-2) = subplot(3,2,3)
% e.g. hsubplot(AxHdl,3,2,2,1) = subplot(3,2,3)
% e.g. hsubplot(3,2,[1,2],1) = subplot(3,2,[1,3])
%
% NOTE: To make axes + labels fill the outer position (pos+tight=outer) use
%       set(gca,'looseinset',[0 0 0 0]);
% NOTE: To fix axes position (irrespective of changing labels) use
%       set(gca,'ActivePosition','position')
%
% SEE: hSubPos, hspo

% PREC: hSUBPLOT, hSubPos
% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2008-11-25, v.4a:
% AUTH: HM, 2013-09, v4a1: Fix case nargin == 0.
% AUTH: HM, 2014-02, v4a2: Add r < 0 => linear index rows first.

Narg = nargin;
if (Narg < 1) || ~ishandle(varargin{1}) || ~strcmpi(get(varargin{1},'type'),'axes'),
	H = axes;
else
	H = varargin{1};
	varargin(1) = [];
	Narg = Narg - 1;
end

%% NofRows, NofCols, RowNo, ColNo, Margin[l,b,r,t], Spacing(h,v), Padding[l,b,r,t]
while length(varargin)<3, varargin{end+1} = 1; Narg=Narg+1; end
varargin{8} = [];
[R,C,r,c,M,S,P] = deal(varargin{1:7});

if isempty(c),
	if any(abs(r)>C*R | r==0), error('Index exceeds table dimensions.'); end
	% [c,r] = ind2sub([C,R],r);
	if r<0, [r,c] = ind2sub([R,C],abs(r));
	else [c,r] = ind2sub([C,R],r);
	end
end;
if isempty(M), M = [0 0 0 0]; end	% Default Margins
if isempty(S), S = [0 0]; end		% Default Spacing
S = S/2;
M = M - [S,S];		% subtract the spacing added back later
MC = 1-M(1)-M(3);	% MC = full width minus margins.
MR = 1-M(2)-M(4);	% MR = full height minus margins.

%%
c = [min(c)-1,max(c)-min(c)+1];
r = [R-max(r),max(r)-min(r)+1];
pos = [c(1)/C r(1)/R c(2)/C r(2)/R];
pos = pos.*[MC MR MC MR];
pos = pos + [M(1:2),0,0];
pos = pos + [S,-2*S];					% shave 1/2 spacing off each side

% Only if Margin & Spacing are given but no Padding use as precise axes position.
% Otherwise take as OuterPosition with or without defining LooseInsert.
if any(pos > 1), error('Axes position beyond figure boundaries.'); end
if Narg == 6,
	set(H,'unit','normal','pos',pos);
else
	set(H,'unit','normal','outerpos',pos);
	if ~isempty(P), set(H,'loose',P); end
end
Pos = get(H,'pos');
