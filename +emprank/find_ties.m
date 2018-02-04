function rankties = find_ties(ranks)
%EMPRANK.FIND_TIES returns the number of ties % corresponding to each rank value. 
% 
% 

    unique_ranks = setdiff(unique(ranks),0);
    nranks = length(unique_ranks);
    rankties = zeros(nranks,length(ranks));
    
    for ii=1:nranks
        rankties(ii,:) = (ranks==unique_ranks(ii));
    end
    
    rankties = sparse(rankties);