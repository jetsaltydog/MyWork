a = 0; b = 2;
n = 4;
h = (b-a)./n;
x=linspace(a,b,n+1); 
I=(h/3)*(f(a)+4*sum(f(x(2:2:end-1)))+2*sum(f(x(3:2:end-2)))+f(b)); %Simpson's
I2=(h/2)*(f(a)+2*sum(f(x(2:end-1)))+f(b));  %Trapezium
x=linspace(a+h/2,b-h/2,n); 
I3=h*sum(f(x)); % Midpoint 
I4 = integral(f, a, b); 
[I I2 I3 I4 8./3]