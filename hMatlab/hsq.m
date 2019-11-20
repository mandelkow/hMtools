function x = hsq(x,r)
%HSQ [***1a++] Squeeze forward i.e. merge some array dimensions with preceding.
%
% y = hsq(x(:,:,:,:),[2,3]) % = reshape(x(:,:,:,:),[],size(x,4));
%
% Note that pure reshape actions do not copy data in memory.
%
% SEE ALSO: RESHAPE, SQUEEZE

% AUTHOR: Hendrik Mandelkow, 2012
% AUTH: HM, 2012, v2a

if nargin < 2,
    x = squeeze(x);
    return
end

s = size(x);
s(end+1:max(r(:))+1) = 1;
r = sort(r(:),1,'descend');
for r=r(:).',
    s(r-1)=s(r-1).*s(r);
    s(r)=[];
end
x = reshape(x,[s,1]); % ensure length(s) > 1
