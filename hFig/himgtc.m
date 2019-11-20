function tmp = himgtc(tc,img)
%[2b+] OLD! Time course from brain images(x,y,t), point and click each voxel.

% AUTHOR: HM, 2006-03-30, ver. 1BC
% TODO: Quitting doesn't work.

if nargin < 2,
    % tc = img(:,:,:);
    img = tc(:,:,1);
end;
img = img(:,:,1);
tc = tc(:,:,:);

if ishandle(img),
    axes(img);
    H = gca;
    Fig1 = gcf;
else
    Fig1 = figure('name','ENTER POINTS OR HIT ONLY RET TO QUIT.');
    imagesc(img(:,:,1).');
    axis image;
    H = gca;
end

Fig2 = figure;
xy = 1;
while 1,
    axes(H);
    xy = round(ginput(1));
    if isempty(xy), break; end;
    clear tmp;
    for n = 1:size(xy,1),
        tmp(:,n) = squeeze(tc(xy(n,1),xy(n,2),:));
    end;
    figure(Fig2);
    h = plot(tmp);
    set(gca,'colororder',circshift(get(gca,'colororder'),size(tmp,2)));
    hold on;
    legend(h,sprintf('x,y= %u, %u',xy(n,1),xy(n,2)));
end;
