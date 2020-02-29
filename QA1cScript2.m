x = 1; a = x; h = linspace(0,1,1e6);

approx1 = (-fun(a - (2*h)) + 16*fun(a-h) -30*fun(x) + ...
    16*fun(a + h) - fun(a + 2*h))./(12*h.^2);

approx2 = (35*fun(a) - 104*fun(a+h) + 114*fun(a+2*h) - ...
    56*fun(a + 3*h) + 11*fun(a + 4*h))./(12*h.^2);


absErr1 = abs(approx1 - fun2nd(1));
absErr2 = abs(approx2 - fun2nd(1));

loglog(h, absErr1, 'g', h,absErr2, 'b');