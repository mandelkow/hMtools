function img = hmask2img(kimg,mask)
% hMask2Img:1b1: img = hmask2img(kimg,mask)
%
% kimg = masked image vectors (1D)
% mask = 2D,3D,MD image mask
%
% SEE ALSO: kimg = himg2mask(img,mask)

% AUTHOR: Hendrik Mandelkow

mask = logical(mask);
sz = size(kimg);
if islogical(kimg),
	img = false([numel(mask),sz(2:end)]);
else
	img = zeros([numel(mask),sz(2:end)],class(kimg));
end
img(mask,:) = kimg(:,:);
img = reshape(img,[size(mask),sz(2:end)]);
