%% HFIG - Hendrik's Graphics Tools
%
%% Files I - Goodies
%   himgtile       - [***4B2+] Reshape 4D array of images into 2D for display.
%   himgtilec      - [***1b++] Display stack of images in 2D montage.
%   hplotchan      - [**2AB3++] Plot array as line series computing offset in y.
%   hplotdx        - [***3a++] Create xdata and plot ydata.
%   hhline         - [****1a] Add horizontal lines to current axes.
%   hvline         - [****1a] Add vertical lines to current axes.
%
%   herrbar        - [**1A++] Single-line errorbars without T.
%   herrbarx       - [**1A++] Error bars in x (as single line).
%   herrbarxt      - [**1A++] Error bars in X with T caps.
%   herrbarxy      - [**1A++] Plot errorbars in xy (as single line).
%
%   himg3ort       - [**1a++] 3 orthogonal views Tra,Cor,Sag of XYZ volume data.
%   himg3ortmip    - [**3a++] 3 orthogonal views Tra,Cor,Sag of XYZ volume data (max.intensity projection).
%
%% Files II
%   clo            - [****1a] close all - the most used Matlab command
%   hlabeltxyz     - hLabelTXYZ = @(t,x,y,z) [title(t),xlabel(x),ylabel(y),zlabel(z)];
%   haxdx          - [**1b+] Add/change Xdata to line objects in axes.
%   haxlabel       - [*2B+] Add text to (top left) corner of axes.
%   haxtilelabel   - *1AB+ function [H,P] = haxtilelabel(Ax,NR,NC,Lab,Pos,varargin)
%   haxtilelabelxy - [1b+] Apply X/YTickLabel from string matrix Lab{R,C} to axes.
%   haxyy          - [+2a2] Create double axes (right and top) see PLOTYY.
%   hback          - HBACK(Handles) [3B+] Send to back graphics objects. [= uistack(h,'bottom')]
%   hbardots       - [***1b++] Barplot with data points.
%   hbarerrdots    - :***1b++: Barplot w data points and errorbars.
%   hbestrect      - [**1A1] Divide integer N1N2 into two integer factors as evenly as possible.
%   hclimsym       - [**1a] Clim symmetric about zero. [ClimNew,ClimOld] = hclimsym(ax,clim)
%   hcloseallbut   - hCloseAllBut - Close all figs except some.
%   hcolorbar      - [2bc]
%   hcolstyle      - [**3a+] ParVal = hcolstyle(LineHandle,[LineSpec,][Par,Val,Par,Val,...])
%   hfa            - [**1A2++] Find (all) axes (in current figure).
%   hff            - [**1A3++] Find (all) figures. Sort by number.
%   hfigeqax       - [**4A1+] Make all xy axes equal in scale.
%   hfront         - hfront(Handles) [*3B+] Bring to front graphics objects.
%   him2ma         - hImg2Mask:1b: kimg = himg2mask(img,mask)
%   himg2mask      - hImg2Mask:1b: kimg = himg2mask(img,mask)
%   himgbestrect   - [3A] Find optimal tiling for images by minimizing the circumference.
%   himgtc         - [2b+] OLD! Time course from brain images(x,y,t), point and click each voxel.
%   hlogc          - [*1b++] hlogc(ImageHandle) Toggle logarithmic color scale h.cdata = log10(h.cdata)
%   hlogx          - Toggle axes xscale log/lin.
%   hlogy          - Toggle axes yscale log/lin.
%   hma2im         - hMask2Img:1b1: img = hmask2img(kimg,mask)
%   hmask2img      - hMask2Img:1b1: img = hmask2img(kimg,mask)
%   hnp            - Toggle NextPlot= replaceChildren
%   hplotyy        - hPlotYY 1ab: Simpler syntax for PLOTYY() - hPlotYY(Y1,Y2).
%   hsavefigs      - [**2a3+] Fnames = hsavefigs(FigNrs,Extension(s),OVERWRITE,NameOpt)
%   hsetcolors     - hsetcolors(H,cmap): Set color of multiple objects according to cmap.
%   hsp            - [**4A2] SUBPLOT based on "OuterPosition" property.
%   hsubpos        - hSubPos *1B: Position vector for OuterPosition of subplot.
%   htext          - [*1a++] Position text object using cardinal directions N,NE,E,...
%   hxdata         - hXdata 3b: Add/change Xdata to line objects in axes.
%   hxline         - [****1a] Add vertical lines to current axes.
%   hyline         - [****1a] Add horizontal lines to current axes.
%
%% ETC
%   hxgrid         - [***1a] Add vertical lines to current axes.
%   hxygrid        - [**1a+] Add XY grid lines to current axes.
%   hygrid         - [***1a] Add y lines to current axes.
