% HMTOOLS - Hendrik's Matlab Tools
%
% Files
%   hanovagr       - [***3ab++] Multiple ANOVA1 on MD array with size(X,G) groups and size(X,R) repetitions.
%   hanovagrnan    - [***3ab++] Multiple ANOVA1 on MD array with size(X,G) groups and size(X,R) repetitions.
%   hcdwhich       - [*1a2+] cd to file: OldDir = @(Fname) cd(hfileparts(which(Fname)))
%   hdemean        - [*1a1++] Subtract (nan)mean along one dim.
%   hdeo           - [**5a1++] Reshape data array dat by taking pieces of length dx along dim
%   hdetrend       - [*1b+] Extend DETREND with dimension and polynomial parameters.
%   hloadorgtables - [***1ab++] Read all org-mode tables (separator |) from text file(.org).
%   hloadorgtab    - [**3ab++] Read *one* org-mode table (separator |) from text file (.org).
%   hminmax        - hminmax = @(x) [ min(x(:)), max(x(:)) ]
%   hmovavg        - [**3AB+] Moving average filter of 2*N+1 points (symmetric).
%   hmovmean       - [**2B1++] Moving nanmean filter of N points.
%   hmovvar        - [**2A+] Moving average filter of 2*N+1 points (symmetric).
%   hnmi           - Compute nomalized mutual information I(x,y)/sqrt(H(x)*H(y)).
%   hnormalize     - hNormd = @(C,d) bsxfun(@rdivide,C,sqrt(sum(C.^2,d)));
%   hoed           - odat = hObsEvtDat(Obs,Evt,Dat) - Replace pieces of vector Dat with columns of Obs at locations in Evt.
%   hpolyreg       - [**2b1+] Polynomial fit and detrend along specified array dimension.
%   hpolybase      - [**1a++] Polynomial basis function set.%   hrank          - [**1a++] Convert array to sort rank of values.
%   hrankd         - [**2ab++] Convert array to sort rank along one dim.
%   hrescale       - [*3B++] Rescale data array linearly.
%   hwindex        - [**2ab+++] Reshape data splitting one dim into (overlaping) windows.
%   hzerox         - [*3a+] Find zero crossings in a (time-series) vector.
%
% Old Junk?
%   hmovmax        - [*1A-] Moving maximum y = hmovmax(x,N,P) -> y(n) = max(x(n-P:n-P+N))
