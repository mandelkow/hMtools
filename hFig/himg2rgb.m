function Cdata = himg2rgb(Himg,Cmap,Clim)
%[**1a++] Convert indexed or scaled image (handle) to RGB.
% Cdata = himg2rgb(Himg,Cmap,Clim)

% AUTHOR: Hendrik Mandelkow, 2013

Ax = get(Himg,'parent');
%< Fig = get(Ax,'parent');
if nargin < 2 || isempty(Cmap), Cmap = colormap(Ax); end
if nargin < 3 || isempty(Clim), Clim = get(Ax,'clim'); end
Cdata = double(get(Himg,'cdata'));
%< Rng = [min(Cdata(:)),max(Cdata(:))];
if strcmpi(get(Himg,'cdatamapping'),'scaled'),
    Cdata = (Cdata-Clim(1))./diff(Clim);
    Cdata = max(Cdata,0); Cdata = min(Cdata,1);
    Cdata = interp1([0.5:size(Cmap,1)]./size(Cmap,1),Cmap,Cdata,'linear','extrap');
    Cdata = max(Cdata,0); Cdata = min(Cdata,1);
else
    % error('Indexed images not implemented.');
    % Cdata = ind2rgb()
    Cdata = reshape(Cmap(Cdata,:),[size(Cdata),3]);
end
if nargout < 1,
    set(Himg,'cdata',Cdata);
    Cdata = Himg;
end
