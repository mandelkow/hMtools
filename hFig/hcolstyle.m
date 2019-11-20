function S = hcolstyle(varargin)
%HCOLSTYLE [**3a+] ParVal = hcolstyle(LineHandle,[LineSpec,][Par,Val,Par,Val,...])
%
% LineSpec = hcolstyle('4.5r:d') =
% {'LineStyle',':','Color','r','Marker','d','LineWidth',[4.5]}

% AUTH: HM 17.10.2004, ver 2A.
% AUTH: HM, 2013-09, v.3b: Add LineWidth to LineSpec.

if isempty(varargin{1}), varargin(1)=[]; end
if ishandle(varargin{1}),
    h = varargin{1}; varargin(1) = [];
else
    h = [];
end
if ~mod(length(varargin),2), % if length is even...
    S = varargin;
else
    LineSpec = varargin{1}; varargin(1) = [];
    %% find any number representing line width AT THE FRONT
    if 0
%         n = regexp(LineSpec,'\d','once');
%         if n,
%             [LW,~,~,m] =  sscanf(LineSpec(n:end),'%f');
%             LineSpec(n:n+m-2) = ''
%         end
    else
        [LW,~,~,n] = sscanf(LineSpec,'%f');
        LineSpec = LineSpec(n:end);
    end
    %%
    S = {'LineStyle','Color','Marker'};
    [S{2,1:3},msg] = colstyle(LineSpec); error(msg);
    if LW,
        S(:,end+1) = {'LineWidth'; LW};
    end
    S(:,cellfun('isempty',S(2,:))) = [];
    S = S(:)';
    S = [S,varargin];
end;

if ~isempty(h),
    set(h,S{:});
end;

% function [LineWidth,LineSpec] = hLineWidth(LineSpec)
