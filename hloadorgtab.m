function [C,F,S,T] = hloadorgtab(OrgFile,TabNr)
%HLOADORGTAB [**3ab++] Read *one* org-mode table (separator |) from text file (.org).
%
% [C,F,S,T] = hloadorgtab(OrgFile,[TableNr])
% C{n,m}:cells, F.field{n}, S(n):structures, T:titles
%
% SEE ALSO: hloadorgtables

% AUTHOR: Hendrik Mandelkow, 2012
% AUTH: HM, 2012-09-28, v2a:

% T = textscan(fid,'%s','Delimiter','|','CommentStyle','#')
% T = reshape(deblank(T{1}),7,[]).'

REPLACE = '';
TRANSPOSE = false;

if nargin < 2, TabNr = 1; end

%%
[fid,msg] = fopen(OrgFile,'r'); error(msg);
for n=1:TabNr,
    % Skip lines not starting with |
    T = textscan(fid,'%1[^|]%s','Delimiter','\n','CollectOutput',true,'Whitespace','');
    % Keep last line as title. (Could keep paragraph.)
    % TODO: Avoid newline ascii(10) here or below. 
    try T = strtrim([T{1}{end,:}]); catch, T = []; end
    % Read lines starting with |
    C = textscan(fid,'|%s','Delimiter','\n'); C = C{1};
end
fclose(fid);

if isempty(C), error('Org-table #%u not found.',TabNr); end

for n=1:size(C,1),
    % Catch divider lines: |---+---|
    tmp = textscan(C{n,1},'%[-]+','Delimiter','|','Whitespace','');
    if isempty(tmp{1}),
        tmp = textscan(C{n,1},'%s','Delimiter','|','CommentStyle','#');
        C{n} = tmp{1};
    else
        C{n} = [];
    end
end
C = cat(2,C{:});
C = deblank(C).';
% C(:,1) = []; % No need with read pattern '|%s'

%%
if nargout > 1,
    H = C(1,:); % Header line.
    % N = cellfun(@(s) sscanf(s,'%f'),C,'UniformOutput',false);
    N = cellfun(@(s) sscanf(s,'%f%s'),C,'UniformOutput',false);
    % TODO: Catch strings like 13abc as strings!?
    % Tidx = text index = not numeric, but not empty.
    Tidx = cellfun(@isempty,N) & ~cellfun(@isempty,C);
    N(Tidx) = C(Tidx); % Data as cell array of strings and numbers.
    C = N; % *** ?
    C(1,:) = H; % Workaround for strings like 12h
    N(1,:) = [];
    clear Tidx
    
    for n = 1:length(H)
        % Prevent invalid field names:
        try
            tmp = regexprep(H{n},'\W',REPLACE);
        catch
            warning('Invalid title in column %u:',n);
            disp(H{n});
            H{n} = [];
            continue
        end
        if ~strcmp(tmp,H{n}),
            warning('Change invalid field names: %s -> %s',H{n},tmp);
            H{n} = tmp;
        end
        clear tmp
        if isempty(H{n}),
            continue;
        end
        
        c = N(:,n);
        inum = cellfun('isclass',c,'double');
        
        if all(inum)
            % all numeric
            F.(H{n}) = cell2mat(c);
        else
            % all text or mixed
            F.(H{n}) = c;
        end
    end
    
    % ELEMENTWISE storage
    try
        S = cell2struct(N,H,2);
    catch
        warning('Unable to create structure with these fieldnames:');
        S = H
    end
end
