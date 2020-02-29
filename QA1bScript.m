x = linspace(-5e-8, 5e-8, 250);

g1 = (1-(sech(x)).^2)./(x.^2);
g2 = (tanh(x)./x).^2;

taylor = (1 - (2*x.^2)/3);

plot(x, g1, 'r',x, g2, 'b',x, taylor, 'g');