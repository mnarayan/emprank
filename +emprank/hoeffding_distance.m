function [output varargout]= hoeffding_distance(ranks,varargin)
%EMPRANK.HOEFFDING_DISTANCE returns the weighted hoeffding distance between pairs of ranks
%
% USAGE
%       output = hoeffding_distance(ranks)
%       output = hoeffding_distance(ranks,'exp',2)
% INPUTS 
% - ranks is a matrix of n_ranks x n_attributes. Each column contains ranks ranging from 1 to n_rank in some order for some attribute. 
% - weight_type: (optional) is either 'uniform' or 'exp'. Defaults to 'exp'
% - weight_q: (optional) is value for exponent for exponential weighting case. 
% 
% References: 
% "Visualizing Differences in Web Search Algorithms Using the Expected Weighted Hoeffding Distance"
% Mingxuan Sun, Guy Lebanon, and Kevyn Thompson (2010), WWW'10. 
% 
% "A non-parametric test of independence." Hoeffding, W. (1948). 
% Ann. Math. Statistics, 19: 546-557.
% 

    if(nargin==2)
        weight_type = varargin{1};
        weight_q = 2;
    elseif(nargin>2)
        weight_type = varargin{1};
        weight_q = varargin{2};
    else
        weight_type = 'exp';
        weight_q = .5;
    end

    [nranks nmetrics] = size(ranks);
    tmp_distance = zeros(nmetrics,nmetrics,nranks);
    
    switch weight_type
    case {'exp','Exp'}
        rank_weights = exp_weight(nranks,weight_q);
    case {'unif'}
        rank_weights = ones(1,nranks-1);
    end
        
    for metricNoi=1:nmetrics
        for metricNoj=metricNoi:nmetrics
            for r = 1:nranks
                rank1 = ranks(r,metricNoi); 
                rank2 = ranks(r,metricNoj); 
                if(rank1<rank2)
                    tmp_distance(metricNoi,metricNoj,r) = ...
                                         sum(rank_weights(rank1:rank2-1));
                elseif(rank1>rank2)
                    tmp_distance(metricNoi,metricNoj,r) = ...
                                        sum(rank_weights(rank2:rank1-1));
                end
            end
        end
    end

    output = sum(tmp_distance,3)/(sum(rank_weights)^2);
    output = triu(output,1) + output';
end

function w = exp_weight(n,q)
    % returns weighting vector defined as 
    % w = t^{-q}, t = 1, ..., n-1
    % 
    % Inputs
    %  - n : length of list
    %  - q : exponent, defaults to 2. 
    
    w = 1:n-1; 
    w = w.^(-q);
    
end