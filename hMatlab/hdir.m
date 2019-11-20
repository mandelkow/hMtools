function [Name,Date,Size,DirFlag,Files] = hdir(varargin)
% hDIR **2A+ Read directory as cellstring (see also DIR).
%
% SYNTAX:   [Name,Date,Size,DirFlag,Files] = hdir(Arg)

% AUTHOR: Hendrik Mandelkow
% AUTH: HM 30.08.2003, ver 1A.
% AUTH: HM 04.08.2004, ver 2A. Add multiple arguments.

Files = {};
while ~isempty(varargin),
    Files = cat(1,Files,struct2cell(dir(varargin{1}))');
    varargin(1) = [];
end

%Files = struct2cell(dir(Arg))';
Name = Files(:,1);
Date = Files(:,2);
Size = [Files{:,3}]';
DirFlag = [Files{:,4}]';
