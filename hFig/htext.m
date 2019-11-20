function H = htext(Str,Pos,varargin)
%[*1a++] Position text object using cardinal directions N,NE,E,...
%
% H = htext('Some text...','SW','TextProperty',Value,...)
%
% AUTH: HM, 2013

if ischar(Pos),
    switch upper(Pos)
        case 'N', Pos = [.5,1];
        case 'NE', Pos = [1,1];
        case 'E', Pos = [1,.5];
        case 'SE', Pos = [1,0];
        case 'S', Pos = [.5,0];
        case 'SW', Pos = [0,0];
        case 'W', Pos = [0,.5];
        case 'NW', Pos = [0,1];
    end
end
if isnumeric(Pos), [X,Y] = deal(Pos(1),Pos(2)); end

H = text(X,Y,Str,'unit','norm','hori','left','vert','bot','color',[1 1 1]*0.5);
if X > 0.7, set(H,'hori','right'); end
if Y > 0.7, set(H,'vert','top'); end

if mod(numel(varargin),2),
    Opt = varargin{1};
    varargin(1) = [];
end
if ~isempty(varargin),
set(H,varargin{:});
end
