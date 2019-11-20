function W = himg3ortmip(V,varargin)
%[**3a++] 3 orthogonal views Tra,Cor,Sag of XYZ volume data (max.intensity projection).
%
% W = himgvolortmip(V,x,y,z)
% W = himgvolortmip(...,'vox',[dx dy dz]) % voxel size
%
% SEE ALSO: himg3ort, himg3ortmip

% PREC: himgvolortmip
% AUTHOR: Hendrik Mandelkow, 2012, v3A

%%
try
    if strncmpi(varargin{end-1},'vox',3),
        Voxel = varargin{end};
        varargin(end-1:end) = [];
    end
catch
end
if exist('Voxel','var'),
    for n = find(Voxel~=1),
        V = hinterpft(V,round(size(V,n)*Voxel(n)),n);
    end
end

%%
sz = size(V);
% Replicate missing input for xyz, i.e. z=y=x
if length(varargin)<1, varargin{1} = []; end
for n = length(varargin)+1:3,
    varargin{n} = varargin{n-1};
end
% xyz = [] -> 1:sz(xyz); xyz < 1 -> xyz = round(xyz.*sz(xyz))
for n = 1:length(varargin),
    if isempty(varargin{n}),
        varargin{n} = 1:sz(n);
    else
        tmp = varargin{n};
        tmp(tmp<1) = round(tmp(tmp<1).*sz(n));
        varargin{n} = tmp;
    end
end
[x,y,z] = deal(varargin{:});

% W = cat(1,squeeze(V(:,y,:,:)),squeeze(V(x,:,:,:)));
W = cat(1,squeeze(nanmean(V(:,y,:,:),2)),squeeze(nanmean(V(x,:,:,:),1)));
% V = squeeze(V(:,:,z,:));
V = squeeze(nanmean(V(:,:,z,:),3));
V(size(W,1),1) = 0;
W = cat(2,V,W);

if nargout < 1,
    H = imagesc(W.'); axis image xy; colormap gray;
    if any(W(:)<0),
        colormap hbwr;
        set(gca,'clim',max(abs(get(gca,'clim'))).*[-1 1]);
    end
    %< tmp = get(gca,'XTickLabel'); tmp(tmp>sz(1))=[]; set(gca,'XTickLabel',tmp);
    %< tmp = get(gca,'YTickLabel'); tmp(tmp>sz(2))=[]; set(gca,'YTickLabel',tmp);
    tmp = get(gca,'XTick'); tmp(tmp>sz(1))=[]; set(gca,'XTick',tmp);
    tmp = get(gca,'YTick'); tmp(tmp>sz(2))=[]; set(gca,'YTick',tmp);
    hhline(sz(2)+.5,'-w','color',[1 1 1]*.7);
    hvline(sz(1)+.5,'-w','color',[1 1 1]*.7);
    % set(findobj(gca,'type','line'),'tag','hl_div');
    set(findobj(gca,'-regexp','tag','h[hv]line'),'tag','hl_div');
    
    for n=1:3, 
    if length(varargin{n})>1,
        varargin{n} = [min(varargin{n}),max(varargin{n})];
    end
    varargin{n}((varargin{n}<2)|(varargin{n}>(sz(n)-1))) = [];
    end
    [x,y,z] = deal(varargin{:});
    if 0
        if any(x), hvline(x); end
        if any(y), hvline(y+sz(1)); hhline(y); end
        if any(z), hhline(z+sz(2)); end
    else
        % rectangle('Position',[.5,.5,sz(1:2)],'EdgeColor','g');
        % rectangle('Position',[sz(1:2)+.5,sz(2:3)],'EdgeColor','c');
        rectangle('Position',[1,1,sz(1:2)-1],'EdgeColor','m');
        rectangle('Position',[1,sz(2)+1,sz([1,3])-1],'EdgeColor','g');
        rectangle('Position',[sz(1:2)+1,sz(2:3)-1],'EdgeColor','c');
        if any(x), hvline(x,'c'); end
        if any(y), hvline(y+sz(1),'g'); hhline(y,'g'); end
        if any(z), hhline(z+sz(2),'m'); end
    end
    set(findobj(gca,'-regexp','tag','h[hv]line'),'tag','hl_sli');

    W = H;
    % TODO: Create axes and time-series plot.
end
