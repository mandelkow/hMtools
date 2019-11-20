function hpar(varargin)
%HPAR [***3b4++] Parse input as parameter-value pairs or struct or cell.
%Fieldnames or parameter-value pairs will be declared in the caller workspace.
%
% USAGE:  hpar(struct('a',1,'b',2),{'c',3,'d',4},'e',5)
%         declares: a=1; b=2; c=3;... in the calling workspace.
%
% See also: ASSIGNIN

%% AUTHOR: Hendrik Mandelkow, 2000
% AUTH: HM, 19.10.2000, ver. 1a.
% AUTH: HM, 16.10.2003, ver. 1a1. Cosmetic change.
% AUTH: HM, 16.01.2004, ver. 2a. Handle cell arrays (varargin).
% AUTH: HM, 14.06.2004, ver. 3b. Handle Structures AND Cells.
% AUTH: HM, 05.12.2004, ver. 3b1. Handle empty input.
% AUTH: HM, 04.03.2016, ver. 3ba2. Better Help.
% AUTH: HM, 04.03.2016, ver. 3ba3. Error for non-scalar structures.

while ~isempty(varargin) && ~isempty(varargin{1}),
  if isstruct(varargin{1}) % (scalar) struct
    PV = varargin{1};
    assert(isscalar(PV),'PV must be a *scalar* structure!');
    varargin(1) = [];
    tmp = cellstr(fieldnames(PV));		% cell array of strings.
    for n = 1:length(tmp)
      assignin('caller', tmp{n}, PV.(tmp{n}));
    end
  elseif iscell(varargin{1}) % cell(Parameter / value pairs).
    PV = varargin{1};
    varargin(1) = [];
    for n = 1:2:numel(PV)
      assignin('caller', PV{n}, PV{n+1});
    end
  else % Parameter / value pairs.
    PV = varargin;
    varargin = [];
    for n = 1:2:numel(PV)
      assignin('caller', PV{n}, PV{n+1});
    end
  end
end
