function [output]= intersection_distance(ranks,varargin)
%EMPRANK.INTERSECTION_DISTANCE returns the naive agreement or similarity between two different metrics within each top-k radius
%
% USAGE
% 
% INPUTS 
% 
    ranks(isnan(ranks))=length(ranks);

    topk_matrix = emprank.topk(ranks); 
	[p nmetrics k] = size(topk_matrix); 					

    k_weights = 1./[1:k]';   
    % rho = .9;
    % k_weights = rho.^[0:k-1]; k_weights = k_weights'/sum(k_weights);

	output = zeros(nmetrics,nmetrics,k); 					
	for ii=1:size(ranks,2); 
		for jj=ii+1:size(ranks,2); 
				output(ii,jj,:) = sum(squeeze(topk_matrix(:,ii,:).*topk_matrix(:,jj,:)),1)/p;
		end
	end
    output = output.*permute(repmat(k_weights,[1 nmetrics nmetrics]),...
                                                         [2 3 1]);
    output = sum(output,3);                                                     
    output = output + output';
    output = ones(nmetrics,nmetrics) - output;
    
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
