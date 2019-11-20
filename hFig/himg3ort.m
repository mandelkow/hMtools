function W = himg3ort(V,x,y,z)
%[**1a++] 3 orthogonal views Tra,Cor,Sag of XYZ volume data.
%
% W = himg3ort(Volume(:,:,:),x,y,z)
%
% SEE ALSO: himg3ortmip

% AUTHOR: Hendrik Mandelkow, 2012, v1A

% [x,y,z] = deal(XYZ(1),XYZ(2),XYZ(3));
sz = size(V);

W = cat(1,squeeze(V(:,y,:,:)),squeeze(V(x,:,:,:)));
V = squeeze(V(:,:,z,:));
V(size(W,1),1) = 0;
W = cat(2,V,W);

if nargout < 1,
    imagesc(W.'); axis image xy; colormap gray;
    tmp = get(gca,'XTickLabel'); tmp(tmp>sz(1))=[]; set(gca,'XTickLabel',tmp);
    tmp = get(gca,'YTickLabel'); tmp(tmp>sz(2))=[]; set(gca,'YTickLabel',tmp);
    hhline(sz(2)+.5,'-w','color',[1 1 1]*.7);
    hvline(sz(1)+.5,'-w','color',[1 1 1]*.7);
    % set(findobj(gca,'type','line'),'tag','hl_div');
    set(findobj(gca,'-regexp','tag','h[hv]line'),'tag','hl_div');
    if 0
        hvline(x); hvline(y+sz(1));
        hhline(y); hhline(z+sz(2));
    else
        % rectangle('Position',[.5,.5,sz(1:2)],'EdgeColor','g');
        % rectangle('Position',[sz(1:2)+.5,sz(2:3)],'EdgeColor','c');
        rectangle('Position',[1,1,sz(1:2)-1],'EdgeColor','m');
        rectangle('Position',[1,sz(2)+1,sz([1,3])-1],'EdgeColor','g');
        rectangle('Position',[sz(1:2)+1,sz(2:3)-1],'EdgeColor','c');
        hvline(x,'c'); hvline(y+sz(1),'g');
        hhline(y,'g'); hhline(z+sz(2),'m');
    end
    set(findobj(gca,'-regexp','tag','h[hv]line'),'tag','hl_sli');

    % TODO: Create axes and time-series plot.
end
