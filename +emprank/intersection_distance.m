function [output]= intersection_distance(ranks,varargin)
%EMPRANK.INTERSECTION_DISTANCE returns the naive agreement or similarity between two different metrics within each top-k depth
%
% USAGE
% 
% INPUTS 
% 
% References: 
%   "Comparing top k lists", 
%   Ronald Fagin, Ravi Kumar, D. Sivakumar. (2003)
% 
%   "A Similarity Measure for Indefinite Rankings" 
%   WILLIAM WEBBER, ALISTAIR MOFFAT and JUSTIN ZOBEL. (2010)
%   ACM Transactions on Information Systems, Volume 28, Number 4, http://dx.doi.org/10.1145/1852102.1852106
% 

    switch nargin
    
    case 1
        weight_type = 'k-inverse';
    case 2
        weight_type = varargin{1};
    otherwise
        weight_type = 'k-inverse';
    end

    [p nmetrics] = size(ranks);
    topk_matrix = emprank.topk(ranks);
    definedranks = {};
    for metricno=1:nmetrics
        definedranks = setdiff(1:p,sum(squeeze(topk_matrix(:,metricno,:)),1));
    end
	k = size(topk_matrix,3); 					
    
    switch weight_type
        
    case 'k-inverse'
        k_weights = .5./[1:k]';
    case 'geometric'
        rho = .99;
        k_weights = rho.^(([1:k])); k_weights = k_weights'/sum(k_weights);
    end


	output = zeros(nmetrics,nmetrics,k); 					
	for ii=1:size(ranks,2)
		for jj=ii+1:size(ranks,2)
                agreement = squeeze(topk_matrix(:,ii,:).*topk_matrix(:,jj,:));
                difference = squeeze(topk_matrix(:,ii,:)) - agreement + ...
                                squeeze(topk_matrix(:,jj,:)) - agreement;
                % Case 1: i and j are ranked in both lists
                output(ii,jj,:) = sum(difference,1) / p; 
                % output(ii,jj,:) = sum(difference.* ...
                %                         repmat(k_weights', [p 1]),1);
                % Case 2: i and j are ranked in list 1 but only i or j in list 2
                % Case 3: i and j are mutually exclusively ranked in both 
                % Case 4: i and j are ranked in only 1 list but not the other
		end
	end
    
    output = output.*permute(repmat(k_weights,[1 nmetrics nmetrics]),...
                                                          [2 3 1]);
    output = sum(output,3) ; %/ p;       
    output = output + output';
    %output = ones(nmetrics,nmetrics) - output;
    
    % kmatrix = repmat(fliplr([1:k]')/sum(1:k), [ 1 p nmetrics nmetrics]);
    % kmatrix = permute(kmatrix,[2 3 4 1]);
    % nodal_agreement = sum(output.*kmatrix,4);
    % node_idx = find(sum(sum(nodal_agreement>eps,2),3)~=0);
    %
    % node_struct = {};
    % nargoutchk(1,2);
    % if(nargout>=2)
    %     for ii=1:length(node_idx)
    %             node_struct{ii}.node_no = node_idx(ii);
    %             node_struct{ii}.agreement = ...
    %                     sparse(squeeze(nodal_agreement(node_idx(ii),:,:)));
    %     end
    %     varargout{1} = node_struct;
    % end
	
end

function metric = intersection_metric(rank1,rank2)
    
    
    
end

%%%% 2017, TODO
% % Refactoring Code
% topk_weights = [1:nranks].^q;
% topk_matrix = emprank.topk(ranks);
%
% tmp_distance = zeros(nmetrics,nmetrics);
% for metricNoi=1:nmetrics
%     for metricNoj=metricNoi:nmetrics
%         raw_intersection = topk_metric(:,metricNoi,kk).* ...
%                                     topk_metric(:,metricNoj,kk);
%         tmp_distance =
%
%     end
% end
