function T = hloadtxt(Fname)
% [***1a++] HOWTO read an entire text file into a cellstring.

% AUTHOR: Hendrik Mandelkow, 2018-10-10

[fid,msg] = fopen(Fname); error(msg);
T = textscan(fid,'%s',inf,'Delimiter','\n','CommentStyle','');
fclose(fid);
T = T{1};

%% SCRATCH
%{
% Missing some lines. Probably consecutive empty ones.
T = readtable('h_MvAnaCl_Pca_run.m','FileType','text','ReadVariableNames',0,'Delimiter','\n','CommentStyle','');
T = T{:,1};
%}
