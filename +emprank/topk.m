function output = topk(ranks,varargin)
	% Transform ranks to list of nodes within top-k
	% 
	% INPUT
	% - ranks consists of n_features x n_attributes
	% - k (optional): a number from 1 to n_features but is n_features by default
	% OUTPUT
    % 
    % - a matrix of n_features x n_attributes x k where k <= n_features
    
	if(nargin>=2)
		k = varargin{1}; 
	else
		k = 1:size(ranks,1);
	end
	
	output = zeros(size(ranks,1),size(ranks,2),length(k));
	
	for kk=1:length(k)
		output(:,:,k(kk)) = ranks<=k(kk);
	end
	
end