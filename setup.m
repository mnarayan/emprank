%%%%%%%%%%%%%%%%%%%%
USE_LIGHTSPEED = false;
USE_TESTS=true;
USE_MEX=false;
%%%%%%%%%%%%%%%%%%%%
MATLABDIR =[getenv('HOME') filesep 'MATLAB'];
MATLIBPATH=[getenv('HOME') filesep 'MATLAB' filesep 'matlab-library'];
%%%%%%%%%%%%%%%%%%%%

% External packages specific to this class
addpath('external');
addpath(fullfile('external','kendalltau')); 
if(USE_LIGHTSPEED)
	addpath(fullfile('external','lightspeed')); 
end
if(USE_MEX)
	addpath(fullfile('external','mex')); 
end
addpath(genpath(fullfile(MATLIBPATH,...
				'lib','KPMtools')));
addpath(genpath(fullfile(MATLIBPATH,...
				'lib','MATLAB-ParseArgs')));
