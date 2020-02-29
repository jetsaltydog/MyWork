fun = @(x) log(x).*sin(x).*cos(1./(1+x.^2));
x = 0; 
A = zeros(1,120);
B = zeros(1,120);

it = 0;
while x < 12
    x = x + 0.1;
    b = integral(fun, x, 0);
    it = it + 1;
    B(it) = b;
    A(it) = x;
end

plot(A,B,'r')
line(xlim,[0 0],'Color','b')
