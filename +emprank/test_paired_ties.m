function test_paired_ties
    
    n = 10;
    disp('Test no ties');
    metric = randperm(n,n);
    [J L R] = emprank.paired_ties(metric,metric);
    assert(sum(J+L+R)==0,'There should be no ties')
    
    disp('Test with equal ties')
    metric = randi(n,1,n);
    [J L R] = emprank.paired_ties(metric,metric);
    [metric' J L R]
    assert(sum(L)==0,'There should be no left only ties')
    assert(sum(R)==0,'There should be no right only ties')
    
    disp('Test with unequal ties ranks')
    metric1 = randi(n,1,n);
    metric2 = randi(n,1,n);        
    [J L R] = emprank.paired_ties(metric1,metric2);
    [metric1' metric2' J L R]