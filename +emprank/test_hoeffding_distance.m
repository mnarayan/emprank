function test_hoeffding_distance
    
    weight_type = 'exp';
    
    n = 100;
    disp('Test identical ranks')
    ranks1 = [1:n]';
    ranks2 = ranks1; 
    emprank.hoeffding_distance([ranks1 ranks2],weight_type)
    
    disp('Test opposite ranks')
    ranks1 = [1:n]';
    ranks2 = flipud(ranks1);
    emprank.hoeffding_distance([ranks1 ranks2],weight_type)
        
    disp('Test difference at top ranks')
    ranks1 = [1:n]';
    ranks2 = ranks1;
    rng('default');
    ranks2(1:50) = randperm(50); 
    emprank.hoeffding_distance([ranks1 ranks2],weight_type)
    
    disp('Test difference at bottom ranks')
    ranks1 = [1:n]';
    ranks2 = ranks1;
    ranks2(end-49:end) = n - randperm(50);
    emprank.hoeffding_distance([ranks1 ranks2],weight_type)
