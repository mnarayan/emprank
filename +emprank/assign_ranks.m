function output = assign_ranks(metric,varargin)
	% function output = assign_ranks(metric)
	% 
	% Returns a table with ranks
	
    switch nargin 
    case 1
        sortdir = 'descend';
    case 2
        sortdir = varargin{1};
    end
    
	useMatlab = (exist('tiedrank')>=2);
	p = length(metric);
	metric = reshape(metric,[p 1]); 
	
    metric(metric==0) = NaN;
    nan_idx = ~isnan(metric);
    n_nan = sum(~nan_idx);         

    switch sortdir
    case 'ascend'
	    rank_metric(nan_idx) = p - n_nan + 1 - ...
                                 assign_naive_ranks(metric(nan_idx)); 
    case 'descend'
	    rank_metric(nan_idx) = assign_naive_ranks(metric(nan_idx)); 
    end
    rank_metric(~nan_idx) = NaN;
    rank_metric = reshape(rank_metric,size(metric));
    
	output = array2table(metric, 'VariableNames', {'rawmetric'});
	output.Properties.RowNames = ...
                cellfun(@num2str,num2cell(1:p),'UniformOutput',false);
	output.rank = rank_metric;
	
end


function ranks = assign_naive_ranks(metric)
    
    p = length(metric);

    % Alternate method for verification
    % [sort_val_ds sort_idx_ds] = sort(metric,'descend');
    % rank_ds(sort_idx_ds) = [1:p];
    % un_metric = unique(metric);
    % for ii=1:length(un_metric)
    %     val = un_metric(ii);
    %     tie_idx = find(metric==val);
    %     n_ties = length(tie_idx);
    %     rank_ds(tie_idx) = sum(rank_ds(tie_idx))/n_ties;
    % end
    % ranks = rank_ds;
    
    [sort_val_as sort_idx_as] = sort(metric,'ascend');
    [sort_val_ds sort_idx_ds] = sort(metric,'descend');

    rank_as = zeros(length(metric),1);
    rank_ds = zeros(length(metric),1);

    rank_as(sort_idx_as) = p + 1 - [1:p];
    rank_ds(sort_idx_ds) = [1:p];

    ranks = (rank_as + rank_ds)/2;
        
end