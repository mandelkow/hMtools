function hlogc(h)
%[*1b++] hlogc(ImageHandle) Toggle logarithmic color scale h.cdata = log10(h.cdata)

% AUTHOR: Hendrik Mandelkow, <2016?

if nargin<1, h = gca; end
h = findobj(h,'type','image');

for h = h(:).',
    H = get(h,'parent');
    UD = get(h,'userdata');
    if isfield(UD,'hlogc'),
        set(h,'cdata',power(10,get(h,'cdata')));
        if strcmpi(get(H,'climmode'),'manual'),
            set(H,'clim',UD.hlogc);
        end
        UD = rmfield(UD,'hlogc');
    else
        UD.hlogc = get(H,'clim');
        set(h,'cdata',log10(get(h,'cdata')));
    end
    set(h,'userdata',UD);
end
