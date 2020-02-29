x = linspace(1,2,1000);
f = 0*x;

fun = @(x) exp(4*x) - 15*exp(3*x) + 155*exp(2*x) - ...
    1335*exp(x) + 5994 - 9270*exp(-x);

x1 = fzero(fun, 1) 
plot(x, fun(x), 'r', x, f, 'b') 
