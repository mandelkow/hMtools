function H = hxdata(H,X)
% hXdata 3b: Add/change Xdata to line objects in axes.
% AUTH: HM, 2000.

% NB: Unlike hObjRescale hXdata will not rescale but replace old xdata.

if nargin < 2,
    X = H;
   H = gca;
end;

%h = [findobj(H, 'type','line'),findobj(H, 'type','image')];
h = findobj(H);
% TODO: Adapt manual limits!
% if strcmp(get(H,'xlimmode'),'manual'),
%     tmp = get(H,'xlim');
%     if length(X)==1,
%         tmp = ???
%     else
%     end
% end
H = [];
for h = h(:)',
    try
        x = get(h,'xdata');
    catch
        x = [];
    end
    if ~isempty(x),
        % x = [0:length(x)-1];
        x = x - min(x(:)); % BETTER!?!
        if length(X)==1,
            x = X * x;
        elseif length(X)==2,
            x = X(1) + X(2) * x;
        else
            x = X(1:length(x));
        end
        set(h,'xdata',x);
        H = [H,h];
    end
end

%%% TEST:
% imagesc(randn(10))
% hhline(5,'linewidth',3)
% hvline(5,'linewidth',3)
% 
% hxdata(gca,[0,2])
% set(gca,'xlimmode','auto')
% axis tight
