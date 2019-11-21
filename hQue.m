% hQue:***2a1++: Execute a queue of matlab jobs (scripts) in given folder.
% A poor man's distributed computing engine.
% USAGE: cd ~/Data/QUE; hQue
% Start this script in a folder serving as the queue.
%
% M-scripts copied to that folder will be moved to a subfolder and executed.
% Subfolders are named {DateTime}_{ScriptName} and contain the original
% Script.m a Script.log (diary) file and (potentially) output files
% created by the script. Finished jobs are indicated by prepending d to the
% job folder e.g. d{DateTime}_{ScriptName}
%
% Multiple computers or Matlab instances can work on the same QUE folder.
% It is convenient to start them in separate "screens" e.g.:
% bash> screen -R Rec1
% bash> matlab -nodesktop -r parpool
% matlab>> cd ../QUE
% matlab>> hQue
% CTRL-a d # detach screen
% bash> screen -R Rec1
% bash> matlab -nodesktop -r parpool
% ...

% AUTHOR: Hendrik Mandelkow, 2015-08-06, v2a1

while true
	Qdir = pwd;
	disp([datestr(now,13),' hQue: Looking for jobs in ',pwd]);
	try
		F = textscan(ls('-tr','*.m'),'%s'); F = F{1};
	catch ERR
		if ~strfind(ERR.message,'No such file or directory')
			rethrow(ERR);
		else
			pause(10);
			continue;
		end
	end
	F = F{1}; % 1st (oldest) file in queue
	D = sprintf('%s_%s',datestr(now,30),F(1:end-2));
	mkdir(D);
	movefile(F,D); % 1st remove script from queue
	cd(D);
	diary([F(1:end-2),'.log']);
	disp(['hQue START: ',F]);
	try
		eval(F(1:end-2)); % ***
	catch ERR
		warning('ERROR in %s\n%s\n',F,ERR.message);
		for n=1:numel(ERR.stack)
			fprintf('> In %s (line %u)\n',ERR.stack(n).name,ERR.stack(n).line);
		end
	end
	disp(['hQue STOP: ',F]);
	diary off
	% cd .. % return to QUE
	cd(Qdir);
	movefile(D,['d',D]);
	close all
	clear all
end
