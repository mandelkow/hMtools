function [varargout] = hloadvar(Fname,varargin)
%HLOADVAR [**1a++] Load into (multiple) variables rather than a structure.
% varargout = struct2cell(load(Fname,varargin{:}));

% AUTHOR: Hendrik Mandelkow, 2015-07-06

varargout = struct2cell(load(Fname,varargin{:}));
