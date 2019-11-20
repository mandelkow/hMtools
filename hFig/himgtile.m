function [img,XYRC,H] = himgtile(img,RC,GRID,Label,DISP,varargin)
%HIMGTILE [***4B2+] Reshape 4D array of images into 2D for display.
%
% SYNTAX: [Img2D,ImgSize,Handles] = himgtile(Img4D,RC,GRID,Label,DISP,LabelOpt)
%   Size = [Rows,Columns]
%   Size = 'rect','square'
% SYNTAX: himgtile(Img4D[, Size]) - without output produces a figure
%
% INFO: If Img2D has the dimensions [Nx, Ny, Nr, Nc], Img2D will have the
% dimensions [Ny*Nr, Nx*Nc]. So the order of the images is top->bottom,
% left-right as in a matrix. If the argument RC=[rows,cols] is given the images
% appear sequentially on grid of size in order L-R, T-B like in a photo album.
%
% Each individual image is displayed in an orientation equivalent to:
%       imagesc(Img(:,:,n).'); axis xy
%
% EXAMPLE: imagesc(himgtile(Img)); axis image;
% ... will display Img(x,y,nr,nc) in the following fashion:
%   x: left -> right
%   y: bottom -> top
%   nr: top -> bottom (rows)
%   nc: left -> right (columns)
%
% SEE ALSO: MONTAGE, HIMGTILEC

% AUTHOR: Hendrik Mandelkow, 2003
% AUTH: HM, 20.01.2003, ver. 1B.
% AUTH: HM, 22.04.2003, ver. 2B. Include size as 2nd arg.
% AUTH: HM, 17.06.2003, ver. 3B. Allow for RC = 'rect','square'
% AUTH: HM, 23.06.2003, ver. 3B1. Better 'rect' algorithm.
% AUTH: HM, 30.07.2003, ver. 3B2. ...
% AUTH: HM, 19.08.2003, ver. 4B. Major CHANGE and bug fix in image ordering.
% AUTH: HM, 25.09.2003, ver. 4B2. Add GRID & define NX...NC for clarity.
% AUTH: HM, 09.03.2004, ver. 4B2. Bugfix, grid on right boundary.
% AUTH: HM, 11.04.2004, ver. 4B3. New option GRID=2. Add output RC. Disable axis image.
% AUTH: HM, 13.04.2004, ver. 4B4. Add image numbers.
% AUTH: HM, 13.04.2004, ver. 4B5. Add DISP.
% AUTH: HM, 13.04.2004, ver. 4B51. Minor bug fix.
% AUTH: HM, 08.08.2004, ver. 5B0. Major remodelling.
% AUTH: HM, 27.03.2006, ver. 5B1. Introduce transposing by "'" or "t"
% AUTH: HM, 17.04.2006, ver. 5B2: Catch complex data.
% AUTH: HM, 28.04.2006, ver. 5B3: BUGFIX cpx data. SEE also himgtilecpx.m
% AUTH: HM, 10.05.2013, ver. 5B4: Replace hbestrect() -> himgbestrect().
% AUTH: HM, 13.08.2017, ver. 5B5: Add hoptile() for RC = handle.

if ~isreal(img) && nargout < 1,
  warning('Complex image data. Use magnitude.');
  img = abs(img);
end
if nargin<4 && nargout>0 && nargout<3,
  DISP = 0;
else
  DISP = 1;
end;

if nargin<3 || isempty(GRID), GRID = 1; end;
% NUMBERS = 0;
% LAYOUT = 0; % 'h'oriz, 'v'ert, 's'quare, otherwise same as matrix dims.

img = img(:,:,:,:);
if nargin > 1 && ~isempty(RC),
  % Transpose data if needed:
  if lower(RC(end))=='t' || size(RC,1)>1,
    img = permute(img(:,:,:,:),[2 1 3 4]);
    % if ischar(RC), RC(end)=''; end
  end
  if lower(RC(1))=='b',
    % RC = hbestrect(size(img(:,:,:),3));
    RC = himgbestrect(size(img(:,:,:)));
  end
  % Rectangular grid ('r','v' or 'h')...
  if ischar(RC) && ~strcmpi(RC,'xy'),
    NoImg = size(img(:,:,:),3);
    Nc = ceil(sqrt(NoImg));
    Nr = ceil(NoImg./Nc);
    if lower(RC(1))=='v',   % vertical rectangle
      [Nc,Nr] = deal(Nr,Nc);
    end;
    RC = [Nr,Nc];
  end;
  if isnumeric(RC),
    if numel(RC)>2
      %< if isgraphics(RC) % Don't work bc of handle-number ambiguity.
      %<  RC = himgoptile(size(img),get(RC,'position'));
      RC = himgoptile(size(img),RC);
    end
    [Nr,Nc] = deal(RC(1),RC(2));
    tmp = Nc*Nr - length(img(1,1,:));
    if tmp > 0,
      img = cat(3,img(:,:,:),NaN*repmat(img(:,:,1),[1,1,tmp]));
    elseif tmp < 0,
      img(:,:,end+tmp+1:end) = [];
    end;
    img = reshape(img,[size(img,1),size(img,2),Nc,Nr]);
    
    [NX,NY,NC,NR] = size(img);
    XYRC = [NX,NY,NR,NC];
    img = permute(img,[2 4 1 3]);
    img = flipdim(img,1);
  else   % MODE XY
    [NX,NY,NC,NR] = size(img);
    XYRC = [NX,NY,NR,NC];
    img = permute(img,[2 4 1 3]);
  end;
else
  RC = [];
  [NX,NY,NR,NC] = size(img);
  XYRC = size(img);
  img = permute(img,[2 3 1 4]);
  img = flipdim(img,1);
end;
sz = size(img);
img= reshape(img,NY*NR,NX*NC);

%% DISP
h = [];
if DISP,
  H = imagesc(img);
  set(H,'UserData',struct('HIT',struct('XYRC',XYRC)));
  axis image;
  if ischar(RC),
    axis xy;
  else,
    axis ij;
    set(get(H,'parent'),'xaxisloc','top');
  end;
  switch GRID % draw gridlines
    case 1, % Use hvline and hhline in gray.
      % hhline([1:NR-1]*NY+0.5,'color','w','linestyle','-');
      % hvline([1:NC-1]*NX+0.5,'color','w','linestyle','-');
      if NR>1, hhline([1:NR-1]*NY+0.5,'color',[1 1 1]*0.5,'linestyle','-'); end
      if NC>1, hvline([1:NC-1]*NX+0.5,'color',[1 1 1]*0.5,'linestyle','-'); end
      
      set(gca,'ytick',[1:NR]*NY-NY/2+0.5,'yticklabel',[1:NR]);
      set(gca,'xtick',[1:NC]*NX-NX/2+0.5,'xticklabel',[1:NC]);
      
    case 2, % Use xgrid / ygrid, shift grid by 0.5.
      set(gca,'ytick',[1:NR]*NY+0.5,'yticklabel',[1:NR]);
      set(gca,'ygrid','on','gridlinestyle','-');
      
      set(gca,'xtick',[1:NC]*NX+0.5,'xticklabel',[1:NC]);
      set(gca,'xgrid','on','gridlinestyle','-');
      
    case 3, % Use xgrid / ygrid, shift xydata by 0.5
      tmp = get(H,'xdata'); % tmp = [1,NX*NC];
      set(H,'xdata',tmp-0.5);
      
      tmp = get(H,'ydata'); % tmp = [1,NX*NC];
      set(H,'ydata',tmp-0.5);
      
      set(gca,'ytick',[1:NR*NY],'yticklabel',[1:NY]);
      set(gca,'ygrid','on','gridlinestyle',':');
      
      set(gca,'xtick',[1:NC*NX],'xticklabel',[1:NX]);
      set(gca,'xgrid','on','gridlinestyle',':');
      
    otherwise,  % Use xygrid, rescale xydata.
      %%% +++ HOWTO rescale images: xdata = [1,N] -> xdata = ([1,N]-0.5)/N*X
      tmp = get(H,'xdata'); % tmp = [1,NX*NC];
      tmp = (tmp-0.5)/tmp(end)*NC;
      set(H,'xdata',tmp);
      
      tmp = get(H,'ydata'); % tmp = [1,NY*NR];
      tmp = (tmp-0.5)/tmp(end)*NR;
      set(H,'ydata',tmp);
      
      set(gca,'xtick',[1:NC],'xticklabel',[1:NC]);
      set(gca,'ytick',[1:NR],'yticklabel',[1:NR]);
      %set(gca,'xticklabel',[],'yticklabel',[]);
      %tmp = {}; tmp([10:10:sz(3)]') = num2cell([10:10:sz(3)]')
      %set(gca,'xticklabel',tmp);
      %tmp = {}; tmp([10:10:sz(4)]') = num2cell([10:10:sz(4)]')
      %set(gca,'yticklabel',tmp);
      
      set(gca,'gridlinestyle','-','xgrid','on','ygrid','on');
      %set(gca,'xcolor',[1 0 1]/2,'ycolor',[1 1 1]/3);
      
      axis tight xy;
  end;
  
  %     % +++ HOWTO compute the true extent of an image from its xdata.
  %     [ny,nx] = size(get(H,'cdata'));
  %     x0 = get(H,'xdata');
  %     dx = diff(x0)/(nx-1);
  %     x0 = x0(1)-dx/2;
  %     y0 = get(H,'ydata');
  %     dy = diff(y0)/(ny-1);
  %     y0 = y0(1)-dy/2;
  %     for n=1:NC*NR,
  %         [x,y] = ind2sub([NC,NR],n);
  %         x = x0 + (x-1)*dx*NC;
  %         y = y0 + (y-1)*dy*NR;
  %         h = text(x,y,num2str(n),'unit','data');
  %         set(h,'fontsize',8,'VerticalAlignment','top','horizontal','left');
  %         set(h,'units','points');
  %         set(h,'pos',get(h,'pos')+[2 0 0]);
  %         %set(h,'color','k','backgroundcolor',[7 9 7]/10);
  %         set(h,'color','k','backgroundcolor','w','margin',1);
  %         set(h,'units','data');
  %     end;
  
  if (nargin > 3) && ~isempty(Label),
    if nargin > 5,
      h = haxtilelabel(gca,NR,NC,Label,[0.01,1-0.05],varargin{:});
    else
      h = haxtilelabel(gca,NR,NC,Label,[0.01,1-0.05]);
    end;
    H = [H,h];
  end;
  if nargout < 1, img = H; end
end
