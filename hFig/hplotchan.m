function [H,MM] = hplotchan(X,MM,dx,Lab)
%[**2AB3++] Plot array as line series computing offset in y.
%
% [H,MM] = hplotchan(X,MM,dx,Lab)
%
% MM(n) will be added to each curve X(:,n). X(:,n) = X(:,n) + MM(n)
% if length(MM)==1 the fixed offset MM is added to each curve.
% if MM==[] a variable offset is computed for each curve
%       such that min(X(:,n+1)) == max(X(:,n))
% if MM == 'm' the offset is fixed at the max.
% if MM(1) == 's' curves are variably scaled equally spaced.
% if dx given: plot([0:size(X,1)-1]*dx,X)
% if Lab given: set(gca,'ylabel',Lab)
%
%% NOTES: Simpler code using modern "broadcasting":
%   % Stack signals without rescaling
%   hplotch = @(X) plot(X - min(X) + cumsum([0,range(X(:,1:end-1))]))
%   % Stack signals scaled to [0,1]
%   hplotchsc = @(X) plot(hrescale(X,[],1) + (0.5:size(X,2))) % scaled
%
% SEE ALSO: PLOT, hplotdx

%% AUTHOR: Hendrik Mandelkow, 2004
% AUTH: HM, 2004, v1a.
% AUTH: HM, 2004, v2ab.
% AUTH: HM, 2006, v2ab1: Correct equal dist. unscaled option.
% AUTH: HM, 06.2006, v2ab2: Add input Lab.
% AUTH: HM, 28.06.2006, v2ab3: Fix ylim space below first line.
% AUTH: HM, 10.2008, v2ab4: Fix zero signals.

if length(X)==length(X(:)),
    H = plot(X);
    MM = [];
    return;
end;
X = X(:,:,:);
Xsz = size(X);
if length(Xsz) > 2,
    if 0,   % OLD:
        %% 1st dim is plotted in x. 2nd dim spreads in y. 3rd dim is
        %% concatinated in x.
        X = permute(X,[1 3 2]);
        X = reshape(X,Xsz(1)*Xsz(3),[]);
    else, % Makes more sense:
        %% 1st dim is plotted in x. 2nd dim is concatinated in x.
        %% 3rd spreads in y.
        X = reshape(X,Xsz(1)*Xsz(2),[]);
    end;
end;
if nargin < 2 || isempty(MM),    % Variable distance:
    MM = [-1*min(X,[],1); max(X,[],1)]; % +++
    MM = cumsum(double(MM(:).')+eps);    % +++
    MM = MM(1:2:end);   % +++
    
    MM = [MM(1),diff(MM)];
    MM(MM==0) = min(MM(MM>0));
    MM = cumsum(MM);
elseif ischar(MM),  % MAX fixed maximal distance:
    if MM(1)=='s',  % SCALE data.
        if isinteger(X),
            X = single(X);  % otherwise scaling won't work
        end;
        % [X,XM,XS] = hdatrescale(X,[0,1],1);
        X = hdatrescale(X,[0,1],1);
        tmp = isinf(X);
        if any(tmp(:)),
            %X(tmp) = (sign(X(tmp))+1)/2;
            X(tmp) = nan;
        end;
    end
    for n=1:size(X(:,:),2), X(:,n) = X(:,n) - nanmean(X(:,n),1); end
    MM = [-1*min(X,[],1); max(X,[],1)]; % +++
    MM = cumsum(double(MM(:)')+eps);    % +++
    MM = MM(1:2:end);   % +++

    MM = max(diff(MM(:)));
end;
if length(MM) == 1,
    MM = [0:size(X,2)-1]*MM;
end;
if nargin < 3,
  dx = 1;
end;
%%% Make sure the zero level falls within the boundaries of min & max.
% XM = mean(X,1); % +++
try
    % X = X + hrepmat(MM,size(X));
    X = X + repmat(MM,[size(X,1),1]);
catch
    for n=1:size(X,2),
        X(:,n) = X(:,n) + MM(n);
    end;
end

if length(Xsz) > 2,
    X = reshape(X,Xsz);
    X = permute(X,[1,3,2]);
    T = [0:Xsz(1)-1]/Xsz(1);
    x = 1;
    H = plot(T + x-1, X(:,:,x))';
    for x = 2:Xsz(2),
        H(x,:) = line(T + x-1, X(:,:,x))';
    end;
    set(H,'color','b');
    set(H(1:2:end,1:2:end),'color',[0 0.5 0]);
    set(H(2:2:end,2:2:end),'color',[0 0.5 0]);
    axis tight;
else
    if nargin > 2,
        T = [0:size(X,1)-1]*dx;
        H = plot(T,X);
    else
        H = plot(X);
    end;
    axis tight;
    
    if 0,
        %%% Set ytick at minimum level of each signal.
        set(gca,'ytick',MM(2:end)-MM(1));
    else
        %%% Set ytick at (original) zero level of each signal.
        %%% WARNING: This may result in an illegal assignment if DC offsets
        %%% of neighbouring signals overlap. Subtracting the mean off
        %%% each signal above will solve that.
        %set(gca,'ytick',MM(1:end));
        %set(gca,'ytick',MM(1:end)+XM);
        try set(gca,'ytick',nanmean(X,1));
        catch warning('Some signals are ZERO?!'); end
    end;
    if exist('Lab','var'),
        set(gca,'yticklabel',Lab);
    else
        set(gca,'yticklabel',[1:length(MM)])
    end
    set(gca,'ygrid','on')
    %set(gca,'xgrid','on','ygrid','on');
    if size(X,1) > Xsz(1),
        set(gca,'xtick',[0:Xsz(3)-1]*Xsz(1));
        %set(gca,'xtick',[0:Xsz(3)-1]*Xsz(1)+Xsz(1)/2);
        set(gca,'xticklabel',[1:Xsz(3)])
        set(gca,'xgrid','on')
        %set(gca,'gridlinestyle','-')
    end;
    % Make sure there is some space below the first and above last line:
    ytick = get(gca,'ytick');
    tmp = min(diff(ytick));
    ylim = get(gca,'ylim');
    ylim(1) = min(ylim(1),ytick(1)-tmp/2);
    ylim(2) = max(ylim(2),ytick(end)+tmp/2);
    set(gca,'ylim',ylim);
end;

if nargout < 1,
    clear H
end;
return;

%%% TEST:
hplotchan(randn(1000,10))

hplotchan(randn(1000,10,5))

tmp = randn(100000,10,5);
hplotchan(tmp)
