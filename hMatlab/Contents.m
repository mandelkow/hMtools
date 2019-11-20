% HMATLAB - extensions to Matlab functions
%
% Files
%   cle         - [****] clear all % alias
%   clim        - [***1a+] Define missing CLIM like XLIM, YLIM,...
%   hcurly      - paren = @(x, varargin) x(varargin{:});
%   hdefaults   - [**1a+] Define and substitute default input parameters.
%   hdir        - hDIR **2A+ Read directory as cellstring (see also DIR).
%   hfilter     - [**2B+] Compute AND apply filter in one.
%   hfiltfilt   - hFILTFILT **2B+ : Compute AND apply filter in one.
%   hflipdim    - for d = D(:)', X = flipdim(X,d); end
%   hfliper     - [***2B] Change orientation of data array. Permute and flip dims.
%   hgenpath    - GENPATH Generate recursive toolbox path.
%   hgrep       - [**1a++] Fname = hgrep(Text,Path,File,Options)
%   hisempty    - [***1a++] Use hisempty(C{:}) to replace cellfun(@isempty,C).
%   hkeep       - [*1a++] Clear all but a few variables.
%   hkeep2      - hkeep2(var1,var2,...) clear all variables except var1, var2
%   hls         - [**2a++] Directory (ls) with output as cellstring.
%   hmax        - [*1b] Max along multiple dimensions.
%   hndgrid     - V = ndgrid(1:size(X,1),1:size(X,2),...)
%   hpar        - [***3b4++] Parse input as parameter-value pairs or struct or cell.
%   hparen      - paren = @(x, varargin) x(varargin{:});
%   hpermute    - hPERMUTE - Do 1st order permutations in array dims.
%   hpolyfit    - hPOLYFIT[*1b+] Loop POLYFIT over array. Better use hPolyReg instead.
%   hrss        - Root sum of squares: y = sqrt(hsum(abs(x).^2, dim));
%   hsize       - hSize(dat, dim) [*3A1+] Same as SIZE but dim can be a vector
%   hsizes      - sz(n,:) = size(varargin{n})
%   hsq         - [***1a++] Squeeze forward i.e. merge some array dimensions with preceding.
%   hstd        - : Standard deviation (y), mean (xm) and centered input (xc).
%   hstrfind    - hStrFind = @(varargin) find(~cellfun(@isempty,strfind(varargin{:})));
%   hsubc       - paren = @(x, varargin) x(varargin{:});
%   hsubp       - paren = @(x, varargin) x(varargin{:});
%   hsum        - [**1a++] Sum over multiple dimensions.
%   htrace      - [**] Side-diagonal trace(s)
%   hwhos       - [**1b] Alternaive layout for WHOS
%   hstrfindrex - hStrFind = @(varargin) find(~cellfun(@isempty,strfind(varargin{:})));

