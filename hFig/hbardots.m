function [H,h] = hbardots(A,B,varargin)
%[***1b++] Barplot with data points.
% H = bar(squeeze(mean(A,1)),varargin{:}); hold on
% x = hbarpos(H);
% plot(x(:,n),A(:,:,n).','+','tag','hBarDots')
% A(n,m,k) => plot m bar groups with k bars and n data points each
%
% SEE ALSO: BAR, hbarerrdots

% AUTHOR: Hendrik Mandelkow, 2016, v1B
if nargin<2,
	if iscell(A),
		try
			B = cellfun(@nanmean,A);
		catch
			B = cell2mat(cellfun(@nanmean,A,'UniformOutput',false)).';
		end
	else
		% B = mean(A,1);
		B = squeeze(nanmean(A,1));
	end
end
H = bar(B,varargin{:});
if ~isempty(A)
	hold on
	try
		x = hbarpos(H);
	catch
		x = hbarxdata(H);
	end
	for n = 1:size(x,2), % loop over nr of bars in a group
		if iscell(A)
			% h{n} = plot(x(:,n),A{n}(:),'+','tag','hBarDots');
			h{n} = plot(x(:,n),A{n}.','+','tag','hBarDots');
		else
			h{n} = plot(x(:,n),A(:,:,n).','+','tag','hBarDots');
		end
	end
end

function [x,y] = hbarxdata(H)
%hBarXdata:**1a1++: Get Xdata & Ydata from barseries obj. for plotting errorbars.
% AUTH: HM
if numel(H)>1
	x = get(cell2mat(get(H,'children')),'xdata');
	x = squeeze(mean(cat(3,x{:}),1));	
	y = cell2mat(get(H,'ydata')).';
else
	x = get(get(H,'children'),'xdata');
	x = shiftdim(mean(x,1));
	y = get(H,'ydata').';
end
