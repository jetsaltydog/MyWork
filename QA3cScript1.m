x = 1; 
h = logspace(-12,1,1000);

fun = @(x) atan(x);
funDeriv = ((-3*fun(x) + 4*fun(x + h./2) - fun(x+h))./h);
% f0 = 0.5 + 0*h;
Err1 = abs(0.5 - funDeriv);
Err2 = abs(h.^2 + (pi*10^-16)./h);

loglog(h, Err1, 'r', h, Err2, 'b')
