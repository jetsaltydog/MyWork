function dydx = RHS(x,y)

E = 1; I = 1;
A = 0.1;
q = 10;
%x = 0;

w     = y(1); 
dydx1 = y(2);
dydx2 = y(3);
dydx3 = (q*x + (1./2)*E*A*(y(2)).^3)./(E*I);

dydx = [dydx1 ; dydx2 ; dydx3];

end