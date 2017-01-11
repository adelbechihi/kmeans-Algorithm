function x = data_generate(N)

    a = 10 * [randn(N,1) + 2.5, randn(N,1) + 2.5];
    b = 10 * [randn(N,1) + 2.5, randn(N,1) - 2.5];
    c = 10 * [randn(N,1) - 2.5, randn(N,1) + 2.5];
    d = 10 * [randn(N,1) - 2.5, randn(N,1) - 2.5];
    e = 10 * [randn(N,1) + 0, randn(N,1) + 0];
    
    
    x = [a;b;c;d;e];
end