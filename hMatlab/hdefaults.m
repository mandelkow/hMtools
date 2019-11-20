function [varargout] = hdefaults(Input,varargin)
%[**1a+] Define and substitute default input parameters.
%
% USAGE: [a,b,c] = hdefaults(varargin,1,2,3)

%% AUTHOR: Hendrik Mandelkow

% DEFAULTS = {[320 240],15,0.9,10,'',30,[]};
% idx = find(~cellfun('isempty',varargin));  % find given inputs
% DEFAULTS(idx) = varargin(idx);          % overwrite defaults
% [SZ,K,a,R,VidFile,Fs,Cmap] = deal(DEFAULTS{:});

varargout = varargin;
idx = find(~cellfun('isempty',Input));  % find given inputs
varargout(idx) = Input(idx);          % overwrite defaults
