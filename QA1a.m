function [t1,t2] = QA1a(y)
% Question A1, a).
% "t1" and "t2" are the two functions that approximate
% the function "fun". "1" and "2" represent "t1" and
% "t2" respectively. 

% I use "deg2rad" because the values in
% the question are in degrees. 
x = deg2rad(y);

t1 = log(2)-((x^2)/4)
t2 = log(2)-((x^2)/4)-((x^4)/96)
fun = log(1+cos(x));

% Absolute and relative errors
absErr1 = abs(t1 - fun) 
absErr2 = abs(t2 - fun)
relErr1 = abs((t1 - fun)/fun)
relErr2 = abs((t2 - fun)/fun)

end

