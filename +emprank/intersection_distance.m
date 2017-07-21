function [output varargout]= intersection_distance(ranks,varargin)
%EMPRANK.INTERSECTION_DISTANCE returns the naive agreement or similarity between two different metrics within each top-k radius
%
% USAGE
% 
% INPUTS 
% 
	
	topk_matrix = emprank.topk(ranks); 
	[p nmetrics k] = size(topk_matrix); 					

	output = zeros(p,nmetrics,nmetrics,k); 					
	for ii=1:size(ranks,2); 
		for jj=ii:size(ranks,2); 
				output(:,ii,jj,:) = squeeze(topk_matrix(:,ii,:).*topk_matrix(:,jj,:));
		end
	end
	
	kmatrix = repmat(fliplr([1:k]')/sum(1:k), [ 1 p nmetrics nmetrics]); 
	kmatrix = permute(kmatrix,[2 3 4 1]); 
	nodal_agreement = sum(output.*kmatrix,4);	
	node_idx = find(sum(sum(nodal_agreement>eps,2),3)~=0);
	
	node_struct = {};
	nargoutchk(1,2);
	if(nargout>=2)
		for ii=1:length(node_idx)
				node_struct{ii}.node_no = node_idx(ii); 
				node_struct{ii}.agreement = ...
                    sparse(squeeze(nodal_agreement(node_idx(ii),:,:)));
		end			
		varargout{1} = node_struct;
	end
	
end

