function [t1,t2] = QA1(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
t1 = log(2)-((x.^2)./4);
t2 = log(2)-((x.^2)./4)-((x.^4)./96);
f = log(1+cos(x));

D1 = abs(t1 - f); D2 = abs(t2 - f);
d1 = abs((t1 - f)./f); d2 = abs((t2 - f)./f);

disp(t1);
disp(t2);
disp(D1);
disp(D2);
disp(d1);
disp(d2);
end

