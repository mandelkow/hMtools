function img = himg2mask(img,mask)
% hImg2Mask:1b: kimg = himg2mask(img,mask)
%
% kimg = masked image vectors (1D)
% mask = 2D,3D,MD image mask
%
% SEE ALSO: hmask2img()

mask = logical(mask);
sz = size(img);
sz = [numel(mask),sz(ndims(mask)+1:end)];
img = reshape(img,sz); % = hsq(img,ndims(mask))
img = img(mask,:);
img = reshape(img,[size(img,1),sz(2:end)]);
