function [img,IJRC,H] = himgtilecell(img,RC,XY)
%HIMGTILEC [***1b++] Display stack of images in 2D montage.
% HIMGTILE simplified using mat2cell2mat.
%
% SYNTAX: [Img2D,ImgSize,Handles] = himgtile(Img4D,RC,GRID,Label,DISP,LabelOpt)
%   Size = [Rows,Columns]
%   Size = 'rect','square'
% SYNTAX: himgtile(Img4D[, Size]) - without output produces a figure
%
% Img of dimensions [r, c, R, C] will have the output dimensions [r*R, c*C]. So
% the order of the images is top->bottom, left-right as in a matrix.
% Given the argument RC=[rows,cols] images will instead be ordered L-R, T-B like
% in a photo album.
%
% By default each individual image panel is displayed in an orientation
% equivalent to: imagesc(Img(:,:,n)); axis ij
% Given the argument XY=true images will be displayed as:
% imagesc(Img(:,end:-1:1,n).'); axis xy
%
% SEE ALSO: HIMGTILE, MONTAGE

% PREC: himgtilecell.m (depreciated name)
%
% AUTHOR: Hendrik Mandelkow, 2013
% AUTH: HM, 2013-05-07, v.1B.

if nargin<2, RC = []; end
if nargin<3, XY = []; end

img = img.*1; % make sure img is numeric not logical

if XY,
	% img = hfliper(img,[-2 1 3 4]);
	img = hfliper(img,[-2 1]);
end
[r,c,R,C] = size(img(:,:,:,:));
% img = mat2cell(img(:,:,:,:),r,c,ones(1,R),ones(1,C));
img = num2cell(img(:,:,:,:),[1 2]); % ++++
if RC,
	if RC == 'b', % best rectangle
		RC = himgbestrect([r,c,R,C]);
	elseif RC == 'h', % horizontal row
		RC = [1 R*C];
	elseif RC == 'v', % vertical column
		RC = [R*C 1];
	end
	[R,C] = deal(RC(1),RC(2));
	% Fill superfluous RC with NaN images.
	for n=numel(img)+1:R*C,
		% img{n} = nan(size(img{1}),'like',img{1});
		img{n} = nan.*img{1};
	end
	img = reshape(img(1:R*C),C,R)';
else % Use size(img) for RC.
	img = reshape(img,R,C);
end
img = cell2mat(img); % ++++

IJRC = [r,c,R,C];
if nargout>2 || nargout<1,
	H = imagesc(img); axis ij
	H.UserData.Sz = IJRC;
	if 0 % Use xy-grid as dividers with labels at the edge
		% set(gca,'ytick',r*[1:R-1]+0.5,'xtick',c*[1:C-1]+0.5);
		set(gca,'ytick',r*[1:R]+0.5,'xtick',c*[1:C]+0.5);
		set(gca,'yticklabel',[1:R],'xticklabel',[1:C]);
		set(gca,'ygrid','on','xgrid','on');
	else % [++-] Use hhlines as dividers with labels placed in center
		set(gca,'ytick',r*[0.5:R]+0.5,'xtick',c*[0.5:C]+0.5);
		set(gca,'yticklabel',[1:R],'xticklabel',[1:C]);
		set(gca,'ygrid','off','xgrid','off');
		hhline(r*[1:R-1]+0.5,'color',[1 1 1]*0.5,'linestyle','-','tag','ygrid');
		hvline(c*[1:C-1]+0.5,'color',[1 1 1]*0.5,'linestyle','-','tag','xgrid');
	end
	if nargout < 1, img = H; end
end
