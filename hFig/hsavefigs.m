function Fnames = hsavefigs(Fig,Ext,OW,NOPT)
% [**2a3+] Fnames = hsavefigs(FigNrs,Extension(s),OVERWRITE,NameOpt)
% eg Fnames = hsavefigs(Fig,'png')
% eg Fnames = hsavefigs([],{'fig','png'})
% NameOpt = 1 / 2 / 3 : modes for automatic name generation
%
% Fnames = hsavefigs([],{'heps'}) % equivalent to:
% print(Fig(n),fname,'-depsc','-r600','-loose');


% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2008
% AUTH: HM, 2014-02, v2a: Added mult. extensions.
% AUTH: HM, 2014-07, v2a1: Allow special chars: +#=
% AUTH: HM, 2015-01, v2a2: Catch empty figure name.
% AUTH: HM, 2016-08, v2a3: Add OW.

%%
if nargin < 1 || isempty(Fig),
	Fig = findobj(0,'type','figure');
	[~,n] = sort([Fig.Number]);
	Fig = Fig(n);
else
	Fig = findobj(Fig,'flat','type','figure');
end
if nargin < 2 || isempty(Ext), Ext = 'fig'; end
if nargin < 3 || isempty(OW), OW = false; end
if nargin < 4 || isempty(NOPT), NOPT = 2; end
%%
Ext = cellstr(Ext);
Fnames = {};
for Ext = Ext(:)',
	Ext = Ext{1};
	for n=1:length(Fig),
		FigName = get(Fig(n),'name');
		switch NOPT
			case 1
				Fname = sprintf('Fig_%s_%u_%s',datestr(now,30),Fig(n),FigName);
			case 2
				if isempty(FigName),
					try warning('SKIP figure %u has no name.',get(Fig(n),'number'));
					catch, warning('SKIP figure %u has no name.',Fig(n));
					end
					continue
				end
				Fname = FigName;
			otherwise
				Fname = sprintf('Fig%.2u_%s',Fig(n),FigName);
		end
		
		Fname = regexprep(Fname,'[\s:]','_'); % replace space by _
		% Fname = regexprep(Fname,'[\W]','-'); % replace non-letters by -
		Fname = regexprep(Fname,'[^\w+#=]','-'); % replace non-letters by -
		
		switch Ext,
			case {'heps'}
				% [++++] HOWTO save EPS figure without bounding box!
				fname = [Fname,'.eps'];
				if ~OW && ~isempty(dir(fname)),
					warning('Skip existing file: %s',fname);
				else
					Fnames{end+1,1} = fname;
					% fprintf('Save %s\n',fname);
					fprintf('\n+ print(%u,''%s'',''-depsc'',''-r600'',''-loose'')',Fig(n).Number,fname);
					print(Fig(n),fname,'-depsc','-r600','-loose');
				end
% 			case {'epsc','epsc2','eps2'}
% 				fname = [Fname,'.eps'];
% 				Fnames{end+1,1} = fname;
% 				fprintf('Save %s\n',fname);
% 				saveas(Fig(n),Fname,Ext);
			otherwise
				if strncmp(Ext,'eps',3),
					fname = [Fname,'.eps'];
				else
					fname = [Fname,'.',Ext];
				end
				if ~OW && ~isempty(dir(fname)),
					warning('Skip existing file: %s',fname);
				else
					Fnames{end+1,1} = fname;
					% fprintf('Save %s\n',fname);
					fprintf('+ saveas(%u,''%s'')\n',Fig(n).Number,fname);
					saveas(Fig(n),Fname,Ext);
				end
		end
	end
end
