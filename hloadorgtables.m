function [TH,TS,CC,TT] = hloadorgtables(OrgFile)
%HLOADORGTABLES [***1ab++] Read all org-mode tables (separator |) from text file(.org).
%
% Extract the following kind of tables from an .org-file:
% (TODO: Might read actual Org-mode table #+NAME:...)
%
% * TabName
% | ColHead1 | ColHead2 | ColHead3 |
% +----------+----------+----------+
% |    data  |    data  |    data  |
% ...
%
% [TH,TS,CC,TT] = hloadorgtables(OrgFile)
% TH.TabName(RowNr).ColHeadX (structure arrays)
% TS.TabName.ColHeadX{RowNr} (scalar structures)
% CC{TableNr} = {RowNr,ColNr}
% TT{TableNr} = 'TableName'
%
% The OrgFile contains numel(TT) tables under the headings TT{:}. The 1st
% table can be represented as a cell array CC{1}{:,:} or a scalar struct
% TS.(TT{1}) or a structure array TH.(TT{1})(:).ColHeadX.
%
% Conversion to table: struct2table(TH(1)) or struct2table(TS(1))
%
% SEE ALSO: TEXTSCAN, hloadorgtab (single_table)

% PREC: hLoadOrtTab_3ab
% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2013-08-08, v1ab:

% T = textscan(fid,'%s','Delimiter','|','CommentStyle','#')
% T = reshape(deblank(T{1}),7,[]).'

%%
WARN = warning('query','hLoadOrgTables:Divider');
TT = {}; CC = {};
[fid,msg] = fopen(OrgFile,'r'); error(msg);
while ~feof(fid),
    % Skip lines not starting with | i.e. not part of a table
    T = textscan(fid,'%1[^|]%s','Delimiter','\n','CollectOutput',true,'Whitespace','');
    T = T{1}; % ???
    % Keep last line before table as title. (Could keep a paragraph.)
    % TODO: Avoid newline ascii(10) here or below. 
    %< try T = regexp([T{1}{end,:}]); catch, T = num2str(length(TT)+1,'Table%u'); end
    try T = regexp([T{end,:}],'\w+','match','once'); catch, T = num2str(length(TT)+1,'Table%u'); end
    % Read one table i.e. lines starting with |
    C = textscan(fid,'|%s','Delimiter','\n'); C = C{1};
    if isempty(C), continue; end
    [C,S,F] = hReadOrgTab(C); % Parse one table.
    TH.(T) = S;
    TS.(T) = F;
    CC{end+1} = C;
    TT{end+1} = T;
end
fclose(fid);
warning(WARN);

function [C,S,F] = hReadOrgTab(C,REPLACE)
if nargin < 2, REPLACE = ''; end
%%
for n=1:size(C,1),
    % Catch divider lines: |---+---| (several "-" followed by "+")
    tmp = textscan(C{n,1},'%[-]+','Delimiter','|','Whitespace','');
    if isempty(tmp{1}), % not a divider line
        tmp = textscan(C{n,1},'%s','Delimiter','|','CommentStyle','#');
        C{n} = tmp{1};
    else
        C{n} = [];
        % warning('hLoadOrgTables:Divider','Divider lines |--+--| are ignored.');
        % warning('off','hLoadOrgTables:Divider'); % show only once per run
        % C{n} = '-----'; % TODO: Retain dividers for later interpretation?
    end
end
% warning('on','hLoadOrgTables:Divider'); % show only once per run s.above
C = cat(2,C{:});
C = deblank(C).';
% C(:,1) = []; % No need with read pattern '|%s'

%%
if nargout > 1,
    H = C(1,:); % Header line.
    % N = cellfun(@(s) sscanf(s,'%f'),C,'UniformOutput',false);
    % N = cellfun(@(s) sscanf(s,'%f%s'),C,'UniformOutput',false);
    [N,c] = cellfun(@(s) sscanf(s,'%f%s'),C,'UniformOutput',false);
		% NOTE: This will read one leading number and anything following as a
		% double array of ascii codes. c>1 means there is more.
    % Tidx = text index = not numeric, but not empty.
    % Tidx = cellfun(@isempty,N) & ~cellfun(@isempty,C);
    Tidx = ~cellfun(@(x) isequal(x,1),c) & ~cellfun(@isempty,C);
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
            % lasterror
            warning('Invalid title in column %u: %s',n,H{n});
            % disp(H{n});
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
        
        if all(inum) % all numeric
            c(cellfun('isempty',c)) = {nan};
            F.(H{n}) = cell2mat(c);
        else % all text or mixed
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
