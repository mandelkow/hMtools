% Toggle NextPlot= replaceChildren
ax = gca;
if strcmp(get(ax,'nextplot'),'replace')
    set(ax,'nextplot','replacechildren');
else
    set(ax,'nextplot','replace');
end
