function B = hpermute(A, P)
% hPERMUTE - Do 1st order permutations in array dims.
% B = hpermute(A, P)
%
% INPUT:	A = array
%			P = [n x 2] n permutations e.g. [1,2; 3,4]
%				first exchange dims 1 and 2 then 3 and 4.
%				P= 0,-1,-2, means counting backwards from the last dim.
%				eg. P=[0,-1] exchange the last two dimensions.

% AUTHOR: Hendrik Mandelkow
% AUTH: HM 6.10.00
% AUTH: HM 15.09.2003, ver. 2A. Fixed to allow singleton dims > ndims(A).

Ndim = max([ndims(A),max(P(:))]);
Bdim = [1:Ndim];

idx = find(P<=0);			% 0 = last dim
P(idx) = P(idx)+Ndim;	% -1 = next to last, -2 = ...

for i = 1:size(P,1),
   Bdim([P(i,[1,2])]) = Bdim([P(i,[2,1])]);
end;

B = permute(A, Bdim);

return;

%%% TEST:
tmp = zeros(3,5,7);
tmp = hpermute(tmp,[2,3]);
size(tmp)
tmp = hpermute(tmp,[2,3;1,4]);
size(tmp)
