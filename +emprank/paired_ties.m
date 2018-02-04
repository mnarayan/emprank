function [J L R tie_xcov] = paired_ties(Xrank,Yrank)
%EMPRANK.PAIRED_TIES returns vector of  left ties, right ties and joint ties.
% Undefined ranks do not count towards ties in this implementation
% 
% joint ties:  J(i) = J(j) = 1, if xi = xj and yi = yj
% right ties:  R(i) = R(j) = 1, if xi ~= xj and yi = yj
% left ties:   L(i) = L(j) = 1, if xi = xj and yi ~= yj
% 
% INPUT
%   - Xrank a n x 1 vector containing ranks for items 1,2,...,n
%   - Yrank a n x 1 vector containing ranks for items 1,2,...,n 
% 
% OUTPUT
%   - J
%   - L
%   - R
%   - tie_xcov : n_ties_X x n_ties_Y matrix of concordance in ties. If entries are larger than 1 then indicates that presence of joint ties. 
    
    ties1 = emprank.find_ties(Xrank); % n_unique x n
    ties2 = emprank.find_ties(Yrank); % n_unique x n

    n = length(Xrank);
    L = zeros(n,1); 
    R = zeros(n,1);
    J = zeros(n,1); 
    
    ties1_idx = find(sum(ties1,2)>=2);
    ties2_idx = find(sum(ties2,2)>=2);
    ties1_mat = full(ties1(ties1_idx,:)); 
    ties2_mat = full(ties2(ties2_idx,:)); 
    
    tie_xcov = ties1_mat * ties2_mat';
    % tie_xcov_l = ties1_mat * (ties2_mat~=1)'
    % tie_xcov_r = (ties1_mat~=1) * ties2_mat'

    
    j_count = 1; l_count = 1; r_count = 1;
    if(~isempty(tie_xcov))
        for ii=1:size(tie_xcov,1)
            for jj=1:size(tie_xcov,2)
                if(tie_xcov(ii,jj)>1)
                    J(find(ties1_mat(ii,:).*ties2_mat(jj,:))) = j_count;
                    j_count = j_count+1;
                else
                    if(jj==1 & sum(any(tie_xcov(ii,:)>1))==0)
                        L(find(ties1_mat(ii,:))) = l_count;
                        l_count = l_count + 1;
                    end
                    if(ii==1 & sum(any(tie_xcov(:,jj)>1))==0)
                        R(find(ties2_mat(jj,:))) = r_count;
                        r_count = r_count+1;
                    end
                end
            end
        end
    end
    
end