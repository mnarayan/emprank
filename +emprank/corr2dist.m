function Xdist = correlation2distance(Xcorr)
% Takes a correlation matrix as input and returns the distance matrix
% given by d = (1-r)/2
% 
% Note: 
% if correlation = -1,  distance = 1.0
% if correlation =  0,  distance = 0.5 
    
    p = size(Xcorr); 
    Xones = ones(p,p);     
    Xdist = (Xones-Xcorr)./2;
    
    if(exist('setdiag'))
        Xdist = setdiag(Xdist,zeros(p,1));
    else
        Xdist(find(eye(p))) = zeros(p,1); 
    end
    
end