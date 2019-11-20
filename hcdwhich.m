function old = hcdwhich(x)
%HCDWHICH [*1a2+] cd to file: OldDir = @(Fname) cd(hfileparts(which(Fname)))
%
% OldDir = hcdwhich(FileOnPath)
%
% AUTHOR: Hendrik Mandelkow, 2018-10, v1a

% PREC: hcdf.m
%% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2018-12-28, v1a1: Rename to hfcd to avoid clash whith cdf
% AUTH: HM, 2018-12-28, v1a2: Add file not found error.
% AUTH: HM, 2019-05-05, v1a3: Rename to hcdwhich, more memorable?

hFpath = @(x) regexprep(x,'[^/\\]*$','');

which(x,'-all') % print which -all
% cd(hfileparts(which(x)));
P = which(x);
if isempty(P), error('File not found on path.'); end
P = hFpath(P);
cd(P);
if nargout, old = pwd; end
