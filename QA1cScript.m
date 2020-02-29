x = linspace(0,2,250); a = x; h = 0.1;

approx1 = (-fun(a - (2*h)) + 16*fun(a-h) -30*fun(x) + ...
    16*fun(a + h) - fun(a + 2*h))/(12*h^2);

approx2 = (35*fun(a) - 104*fun(a+h) + 114*fun(a+2*h) - ...
    56*fun(a + 3*h) + 11*fun(a + 4*h))/(12*h^2);

plot(x, fun2nd(x),'r', x, approx1, 'g', x, approx2, 'b');