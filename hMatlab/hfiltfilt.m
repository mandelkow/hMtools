function [X,b,a] = hfiltfilt(X,Flt,varargin)
% hFILTFILT **2B+ : Compute AND apply filter in one.
%
% SYNTAX:   [Y,b,a] = hfiltfilt(X,FilterFun,FilterFunArguments,...)
%           [Y,b,a] = hfiltfilt(X,Dim,FilterFun,FilterFunArguments,...)
% EG:       [Y,b,a] = hfiltfilt(X,'butter',10,0.2,'high');

% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2004, ver. 1A
% AUTH: HM, 02.2007, ver.2B: Include parameter Dim.
% AUTH: HM, 2013-06, ver.3B: Adapt to FIR* functions.

%% Check input:
if ischar(X),
    varargin = cat(1,{X},{Flt},varargin(:));
    [b,a] = feval(varargin{:});
    freqz(b,a,512,1);
    return;
end;
if isnumeric(Flt),  % Dim given.
    [Dim,Flt] = deal(Flt,varargin{1});
    varargin(1) = [];
else,
    Dim = 0;
end
%% Filter
if Dim && Dim ~= 1,
    Xpr = hpermvec(ndims(X),[1,Dim]);
    X = permute(X,Xpr);
    Xsz = size(X);
end

if strncmp(Flt,'fir',3),
    b = feval(Flt,varargin{:});
    a = 1;
else
    [b,a] = feval(Flt,varargin{:});
end
if any(isnan(X(:))), warning('Input X contains NaNs!'); end
X = filtfilt(b,a,X);

if Dim && Dim ~= 1,
    X = reshape(X,Xsz);
    X = permute(X,Xpr);
end

%% Check output
if any(isnan(X)),   % filter unstable, producing NaNs
    % Prepare parameters for output, convert varargin to string
    for n=1:length(varargin),
        if isnumeric(varargin{n}),
            varargin{n} = num2str(varargin{n});
        else,
            varargin{n} = sprintf('''%s''',varargin{n});
        end;
    end;
    %warning('Filter seems to be unstable. Output is NaN!\n\t%s(%s\b)',...
    error('Filter seems to be unstable. Output is NaN!\n\t%s(%s\b)',...
        Flt,sprintf('%s,',varargin{:}));
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TEST:
% Flt = 'butter'
% tmp = {10,2,'high'}
% for n=1:length(tmp),
%     tmp{n} = num2str(tmp{n});
% end;
% warning('NaN output. Filter seems to be unstable.\n\t%s(%s\b)',...
%     Flt,sprintf('%s,',tmp{:}));
