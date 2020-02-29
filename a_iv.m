x = linspace(-5,25, 1000);

f = 0*x;
fun = @(x) (((5.*(x-1).^2).*sqrt(x+3))./ ...
    (abs(x).*sqrt(2+sin(2.*x)))) - x.^2

plot(x, fun(x), 'r',x, f, 'b');

x1 = fzero(fun, 1)
