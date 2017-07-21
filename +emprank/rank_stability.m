function [stability firstk varargout] = rank_stability(ranks,varargin)
	% 
	% How often did 
	% achieve the top-k ranking across ntrials/measurements
    % No complementary pairs
	% 
	% References:
	% 1. P. Hall and H. Miller. Using the bootstrap to quantify the authority of an empirical ranking. 
	% Ann. Statist., 37:3929–3959, 2009b.
	% 
	%
	% 2. Ranking-Based Variable Selection for high-dimensional data
	% Baranowski, Rafal and Fryzlewicz, Piotr
	% 
	
	[p ntrials] = size(ranks); 
    
    if(nargin>=2)
        stb_thresh = varargin{1};
    else
        stb_thresh = .5;
    end
    
	kradius = 1:1:round(p); 
	stability = zeros(p,length(kradius)); 
    storek = 1;
	firstk = zeros(p,1); 
	node_idx = find(mean(ranks,2))<= max(kradius); 
	n_splits = 1;

	for ii=1:p
		for kk=1:length(kradius)
			stability(ii,kk) = sum(...
			        ranks(ii,:)<=kradius(kk)...
			        )...
                    /(ntrials); 
		end
        try
		[tmpval firstk(ii)] = find(stability(ii,:)>stb_thresh,...
		                        1,'first'...
		                      );
        catch
            warning(sprintf('No top-k value found for Node %d',ii))
        end
                              
	end
	
	% % Principled approach to choose # of stable nodes over all radii
	% % min_k (stability_(k+1)/stability(k)) decreases most rapidly
	% stability_kcum = cumsum(stability,2);
	% [stability_kratio kindex] = min(stability(:,2:end)./stability(:,1:end-1),[],2);
	
    if(nargout>=2)        
        % This seems redundance. Compare with intersection_distance and consolidate. 
    	rank_similarity = zeros(p,p,length(kradius));
    	for kk=1:length(kradius)
    		for ii=1:p
    			for jj=ii+1:p
    					rank_similarity(ii,jj,kk) = ...
                        sum((ranks(ii,:)<=kradius(kk)).* ...
                            (ranks(jj,:)<=kradius(kk))...
                            )/ntrials;
    			end
    		end
    		rank_similarity(:,:,kk) = rank_similarity(:,:,kk) + ...
                                 rank_similarity(:,:,kk)';
    	end
        
    	output.stability = stability; 
    	output.firstk = firstk;
    	output.kradius = kradius;
    	output.similarity = rank_similarity;	    
        varargout{1} = output;
    end
end