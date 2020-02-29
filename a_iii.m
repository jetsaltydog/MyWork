x = linspace(-2,0, 1000);
f = 0*x;

fun = @(x) (exp(x).*tan(x) - 1);

plot(x, fun(x), 'r',x, f, 'b');

x1 = fzero(fun, 9)

