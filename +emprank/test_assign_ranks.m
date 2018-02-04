function test_assign_ranks
    
    n = 10;
    disp('Test no ties');
    metric = randperm(n,n);
    ranktbl = emprank.assign_ranks(metric);
    ranktbl
    
    disp('Test with ties')
    metric = randi(n,1,n);
    ranktbl = emprank.assign_ranks(metric);
    ranktbl
    
    disp('Test with indefinite ranks')
    metric(randperm(n,2)) = 0;    
    ranktbl = emprank.assign_ranks(metric);
    ranktbl