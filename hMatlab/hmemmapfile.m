function [varargout] = hmemmapfile(Fname,varargin)
%HMEMMAPFILE [*1b1+] Like memmapfile() accepting 'Format',struct(...) as input.
%
% EXAMPLE: M = hmemmapfile('FileName.dat','Format',struct('x',zeros(1,5,'uint32',...)
%
% SEE ALSO: memmapfile()

%AUTHOR: Hendrik Mandelkow, 2018-08-24, v1b1: HM fecit

n = find(cellfun(@ischar,varargin));
n = n(strcmpi(varargin(n),'Format')) + 1;
if n && isa(varargin{n},'struct')
  varargin{n} = hstruct2type(varargin{n});
end
[varargout{1:nargout}] = memmapfile(Fname,varargin{:});

function C = hstruct2type(S)
C = {};
for fn = fieldnames(S)'
  fn = fn{1};
  s = S.(fn);
  if isa(s,'struct')
    c = hstruct2type(s);
    c(:,end) = strcat([fn,'_'],c(:,end));
  else
    c = {class(s),size(s),fn};
  end
  C = [C;c];
end

%% TEST
if 0
S = struct('a',uint8(1),'b',single([2 2]));
S.c = S;
S.c.c = S;
% C = hstruct2type(S)
D = hmemmapfile('filename','format',S)
end

%% SCRATCH
%{
if numel(S)~=1, error('Expecting a scalar structure.'); end
Sf = fieldnames(S);
Sc = struct2cell(S);
St = cellfun(@class,Sc,'Uniform',false);
Sz = cellfun(@size,Sc,'Uniform',false);
C = [St,Sz,Sf];
while n<=size(C,1)
end
%}
