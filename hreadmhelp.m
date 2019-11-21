function T = hloadtxt(Fname)
% Read the first contiguous block of comments (%).
% SEE ALSO: hloadtxt()

% AUTHOR: Hendrik Mandelkow, 2019-01-30

[fid,msg] = fopen(Fname); error(msg);
% 1st read one block of NON-comments:
T = textscan(fid,'%[^%]%s',inf,'Delimiter','\n','CommentStyle','');
% Then read one block of comments:
T = textscan(fid,'%[%]%s',inf,'Delimiter','\n','CommentStyle','');
fclose(fid);
T = T{1};

%% SCRATCH
%{
% Missing some lines. Probably consecutive empty ones.
T = readtable('h_MvAnaCl_Pca_run.m','FileType','text','ReadVariableNames',0,'Delimiter','\n','CommentStyle','');
T = T{:,1};
%}
