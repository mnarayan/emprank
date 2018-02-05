function metric = loss(xrank,yrank,varargin)
%EMPRANK.LOSS returns an error loss between ranks in two vectors according to options. Default loss function set to weighted hoeffding distance.     
    
    if(ndims(xrank)==ndims(yrank))    
        ranks = cat(2,xrank,yrank);   
        dist_metric = emprank.hoeffding_distance(ranks);
        metric = dist_metric(1,2);     
    else
        error('Inputs do not match in dimensions')
    end
    
end