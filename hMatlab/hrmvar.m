function [F,S] = hrmvar(MatFile,varargin)
%:**1ab++: Delete variables from .mat file.
% [Fieldnames,Struct] = hrmvar(MatFile,'VarName','VarName',...)

% AUTHOR: Hendrik Mandelkow, 2014-02

MatFile = cellstr(MatFile);
for MatFile = MatFile(:).'
	MatFile = MatFile{1};
	V = varargin(:);
	S = cell2struct(cell(size(V)),V);
	save(MatFile,'-struct','S','-append');
	S = load(MatFile);
	S = rmfield(S,V);
	% disp(['Overwrite ',MatFile]);
	disp(['Save ',MatFile,'  - ',sprintf(' %s',V{:})]);
	save(MatFile,'-struct','S');
	F = fieldnames(S);
end
