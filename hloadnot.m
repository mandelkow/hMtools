function S = hloadnot(Fname,varargin)
%HLOADNOT:**1b++: Load all except the given variables from a mat-file.
% [++++] HOWTO *exclude* select variables from loading:
%     load mydata -regexp ^(?!var1$|var2$|var3$).
% = match one character "." at the beginning "^" if NOT "(?!)" preceded by
% var1 or "|" var2 and the end "$".

% AUTHOR: Hendrik Mandelkow, 2015-08-26

str = sprintf('%s$|',varargin{:});
str = sprintf('^(?!%s).',str(1:end-1));
S = load(Fname,'-regexp',str);
